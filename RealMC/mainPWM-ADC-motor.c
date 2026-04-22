#include "stm32f446xx.h"

#define SERVO_MIN  100U   /* 1.0 ms pulse */
#define SERVO_MAX  200U   /* 2.0 ms pulse */
// Connect D12 to servo, and voltage to 5v, potentiometer to 3.3 and ground and A0
// Use stable input voltage not a low volateg battery


static void small_delay(volatile uint32_t n)
{
    while (n--) {
        __asm__("nop");
    }
}

/* =========================================================
   PWM SERVO on PA6 = TIM3_CH1
   ========================================================= */

static void pwm_servo_init(void)
{
    /* Enable GPIOA clock */
    RCC->AHB1ENR |= RCC_AHB1ENR_GPIOAEN;

    /* PA6 -> Alternate Function mode */
    GPIOA->MODER &= ~(3U << (6U * 2U));
    GPIOA->MODER |=  (2U << (6U * 2U));

    /* PA6 -> AF2 = TIM3_CH1 */
    GPIOA->AFR[0] &= ~(0xFU << (6U * 4U));
    GPIOA->AFR[0] |=  (2U   << (6U * 4U));

    /* Enable TIM3 clock */
    RCC->APB1ENR |= RCC_APB1ENR_TIM3EN;

    /*
       Timer clock assumed = 16 MHz

       16 MHz / 160 = 100 kHz
       tick = 10 us

       ARR = 2000 -> 20 ms period
       50 Hz servo frequency
    */

    TIM3->PSC = 160U - 1U;
    TIM3->ARR = 2000U - 1U;

    /* PWM mode 1 on CH1 */
    TIM3->CCMR1 &= ~(7U << 4);
    TIM3->CCMR1 |=  (6U << 4);

    /* Enable preload */
    TIM3->CCMR1 |= TIM_CCMR1_OC1PE;
    TIM3->CR1   |= TIM_CR1_ARPE;

    /* Enable channel output */
    TIM3->CCER |= TIM_CCER_CC1E;

    /* Neutral servo position (1.5 ms) */
    TIM3->CCR1 = 150U;

    /* Update registers */
    TIM3->EGR |= TIM_EGR_UG;

    /* Start timer */
    TIM3->CR1 |= TIM_CR1_CEN;
}

/* =========================================================
   ADC on PA0 = channel 0
   ========================================================= */

static void adc_init_pa0(void)
{
    /* Enable GPIOA clock */
    RCC->AHB1ENR |= RCC_AHB1ENR_GPIOAEN;

    /* PA0 -> analog mode */
    GPIOA->MODER |= (3U << (0U * 2U));

    /* Enable ADC1 clock */
    RCC->APB2ENR |= RCC_APB2ENR_ADC1EN;

    small_delay(1000);

    /* ADC prescaler */
    ADC->CCR &= ~(3U << 16);

    /* 12-bit resolution */
    ADC1->CR1 &= ~(3U << 24);

    /* Sampling time channel 0 */
    ADC1->SMPR2 |= (7U << 0);

    /* Sequence length = 1 */
    ADC1->SQR1 &= ~(0xFU << 20);

    /* Channel 0 first conversion */
    ADC1->SQR3 &= ~(0x1FU << 0);

    /* Enable ADC */
    ADC1->CR2 |= ADC_CR2_ADON;

    small_delay(1000);
}

static uint16_t adc_read(void)
{
    /* Start conversion */
    ADC1->CR2 |= ADC_CR2_SWSTART;

    while (!(ADC1->SR & ADC_SR_EOC)) {}

    return (uint16_t)ADC1->DR;
}

/* =========================================================
   MAIN
   ========================================================= */

int main(void)
{
    uint16_t adc_value;
    uint32_t ccr_value;

    pwm_servo_init();
    adc_init_pa0();

    while (1)
    {
        adc_value = adc_read();

        /* Map ADC 0..4095 → 1.0..2.0 ms pulse */
        ccr_value = SERVO_MIN +
                    ((uint32_t)adc_value * (SERVO_MAX - SERVO_MIN)) / 4095U;

        TIM3->CCR1 = ccr_value;
    }
}
