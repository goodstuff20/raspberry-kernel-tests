#define PBASE 0x3F000000

#define ENABLE_IRQS_1		(PBASE+0x0000B210)
#define IRQ_PENDING_1		(PBASE+0x0000B204)

#define SYSTEM_TIMER_IRQ_0	(1 << 0)
#define SYSTEM_TIMER_IRQ_1	(1 << 1)
#define SYSTEM_TIMER_IRQ_2	(1 << 2)
#define SYSTEM_TIMER_IRQ_3	(1 << 3)

// void enable_interrupt_controller(void);

void irq_vector_init(void);
void enable_irq(void);
void disable_irq(void);