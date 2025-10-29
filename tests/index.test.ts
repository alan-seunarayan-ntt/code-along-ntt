import { UKGreeting, GreetingOptions } from '../src/index';

describe('UKGreeting', () => {
    let greeting: UKGreeting;

    beforeEach(() => {
        greeting = new UKGreeting();
    });

    test('should create a greeting with UK date format', () => {
        const options: GreetingOptions = { name: 'Test User' };
        const result = greeting.greet(options);

        expect(result).toContain('Good day, Test User!');
        expect(result).toContain('Today is');
        
        // Check for UK date format pattern (DD/MM/YYYY)
        expect(result).toMatch(/\d{2}\/\d{2}\/\d{4}/);
        
        // Check for 24-hour time format pattern (HH:MM)
        expect(result).toMatch(/\d{2}:\d{2}/);
    });

    test('should use default UK locale when none specified', () => {
        const options: GreetingOptions = { name: 'Default User' };
        const result = greeting.greet(options);

        expect(result).toBeDefined();
        expect(typeof result).toBe('string');
    });

    test('should accept custom locale', () => {
        const options: GreetingOptions = { 
            name: 'Custom User',
            locale: 'en-US'
        };
        const result = greeting.greet(options);

        expect(result).toContain('Good day, Custom User!');
    });
});