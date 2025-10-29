/**
 * Sample TypeScript application
 * Demonstrates UK English locale formatting
 */

interface GreetingOptions {
    name: string;
    locale?: string;
}

class UKGreeting {
    private readonly defaultLocale = 'en-GB';

    public greet(options: GreetingOptions): string {
        const locale = options.locale ?? this.defaultLocale;
        const now = new Date();
        
        // Format date in UK style (DD/MM/YYYY)
        const formattedDate = now.toLocaleDateString(locale, {
            day: '2-digit',
            month: '2-digit',
            year: 'numeric'
        });
        
        // Format time in 24-hour format (common in UK)
        const formattedTime = now.toLocaleTimeString(locale, {
            hour12: false,
            hour: '2-digit',
            minute: '2-digit'
        });

        return `Good day, ${options.name}! Today is ${formattedDate} at ${formattedTime}.`;
    }
}

function main(): void {
    const greeting = new UKGreeting();
    
    console.log(greeting.greet({ name: 'Developer' }));
    console.log('Environment setup complete for Ubuntu with UK English locale.');
    console.log('Supported technologies: Node.js, TypeScript, Python, .NET 9');
}

if (require.main === module) {
    main();
}

export { UKGreeting, GreetingOptions };