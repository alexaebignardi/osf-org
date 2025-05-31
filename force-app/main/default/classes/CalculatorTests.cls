@IsTest
public class CalculatorTests {
    @IsTest
    public static void testDivideByZero() {
        try {
            Calculator.divide(10, 0);
            System.assert(false, 'Expected CalculatorException');
        } catch (Calculator.CalculatorException e) {
            System.assertEquals('You still can\'t divide by zero', e.getMessage());
        }
    }
}