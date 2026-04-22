#include "stm32f446xx.h"

/* =========================================================
   Small software delays
   ========================================================= */

/* Short delay used only during ADC startup */
static void small_delay(volatile uint32_t n)
{
    while (n--) {
        __asm__("nop");
    }
}

/* Approximate delay in milliseconds for visible LED blinking
   Adjust this constant if your system clock is different */
static void delay_ms(volatile uint32_t ms)
{
    volatile uint32_t i;
    while (ms--) {
        for (i = 0; i < 4000; i++) {
            __asm__("nop");
        }
    }
}

/* =========================================================
   ADC initialization: PA0 = analog input, ADC1 channel 0
   ========================================================= */

static void adc_init(void)
{
    /* 1. Enable GPIOA clock */
    RCC->AHB1ENR |= RCC_AHB1ENR_GPIOAEN;

    /* 2. Set PA0 to analog mode */
    GPIOA->MODER |= (3U << (0U * 2U));

    /* Optional: no pull-up, no pull-down on PA0 */
    GPIOA->PUPDR &= ~(3U << (0U * 2U));

    /* 3. Enable ADC1 clock */
    RCC->APB2ENR |= RCC_APB2ENR_ADC1EN;

    /* Small delay after enabling ADC clock */
    small_delay(1000);

    /* 4. ADC common prescaler = PCLK2 / 2 */
    ADC->CCR &= ~(3U << 16);

    /* 5. 12-bit resolution */
    ADC1->CR1 &= ~(3U << 24);

    /* 6. Right alignment */
    ADC1->CR2 &= ~(1U << 11);

    /* 7. Single conversion mode */
    ADC1->CR2 &= ~(1U << 1);   /* CONT = 0 */

    /* 8. Software trigger */
    ADC1->CR2 &= ~(3U << 28);  /* EXTEN = 00 */

    /* 9. Sampling time for channel 0
          111 = 480 cycles [safe and easy for teaching] */
    ADC1->SMPR2 &= ~(7U << 0);
    ADC1->SMPR2 |=  (7U << 0);

    /* 10. Sequence length = 1 conversion */
    ADC1->SQR1 &= ~(0xFU << 20);

    /* 11. First conversion in sequence = channel 0 [PA0] */
    ADC1->SQR3 &= ~(0x1FU << 0);
    ADC1->SQR3 |=  (0U << 0);

    /* 12. Turn ADC on */
    ADC1->CR2 |= ADC_CR2_ADON;

    /* Small startup delay */
    small_delay(1000);
}

/* =========================================================
   ADC single conversion
   ========================================================= */

static uint16_t adc_read(void)
{
    /* Start one conversion by software */
    ADC1->CR2 |= ADC_CR2_SWSTART;

    /* Wait until conversion is complete */
    while (!(ADC1->SR & ADC_SR_EOC)) {
    }

    /* Return 12-bit result: 0 to 4095 */
    return (uint16_t)ADC1->DR;
}

/* =========================================================
   LED output: PA5
   ========================================================= */

static void led_init(void)
{
    /* Enable GPIOA clock */
    RCC->AHB1ENR |= RCC_AHB1ENR_GPIOAEN;

    /* Set PA5 as general-purpose output */
    GPIOA->MODER &= ~(3U << (5U * 2U));
    GPIOA->MODER |=  (1U << (5U * 2U));

    /* Optional: push-pull, no pull-up/pull-down */
    GPIOA->OTYPER &= ~(1U << 5);
    GPIOA->PUPDR  &= ~(3U << (5U * 2U));
}

static void led_toggle(void)
{
    GPIOA->ODR ^= (1U << 5);
}

/* =========================================================
   Main
   ========================================================= */

int main(void)
{
    uint16_t adc_value;
    uint32_t delay_value_ms;

    adc_init();
    led_init();

    while (1)
    {
        /* Read analog value from PA0 / channel 0 */
        adc_value = adc_read();

        /* Map ADC range 0..4095 to delay range 10..200 ms */
        delay_value_ms = 10U + ((uint32_t)adc_value * 190U) / 4095U;

        /* Toggle LED using the computed delay */
        led_toggle();
        delay_ms(delay_value_ms);
    }
}
