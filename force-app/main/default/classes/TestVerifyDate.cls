@IsTest
private class TestVerifyDate {

  @IsTest
  static void testDateWithin30Days() {
    // GIVEN
    Date date1 = Date.today();
    Date date2 = date1.addDays(15); // dentro dos 30 dias

    // WHEN
    Date result = VerifyDate.CheckDates(date1, date2);

    // THEN
    System.assertEquals(date2, result, 'Should return date2 when within 30 days of date1');
  }

  @IsTest
  static void testDateBeyond30Days() {
    // GIVEN
    Date date1 = Date.newInstance(2025, 5, 10);
    Date date2 = date1.addDays(40); // fora dos 30 dias

    // WHEN
    Date result = VerifyDate.CheckDates(date1, date2);

    // THEN
    Date expectedEndOfMonth = Date.newInstance(date1.year(), date1.month(), Date.daysInMonth(date1.year(), date1.month()));
    System.assertEquals(expectedEndOfMonth, result, 'Should return end of month date when date2 is beyond 30 days from date1');
  }

  @IsTest
  static void testDate2BeforeDate1() {
    // GIVEN
    Date date1 = Date.today();
    Date date2 = date1.addDays(-5); // data2 antes da data1

    // WHEN
    Date result = VerifyDate.CheckDates(date1, date2);

    // THEN
    Date expectedEndOfMonth = Date.newInstance(date1.year(), date1.month(), Date.daysInMonth(date1.year(), date1.month()));
    System.assertEquals(expectedEndOfMonth, result, 'Should return end of month date when date2 is before date1');
  }
}
