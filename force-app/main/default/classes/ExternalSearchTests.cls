@IsTest
private class ExternalSearchTests {
  
  @IsTest
  static void testPositiveMocking() {
    // GIVEN: Mock with HTTP 200 response
    HTTPMockFactory mock = new HTTPMockFactory(
      200,
      'OK',
      'I found it!',
      new Map<String, String>()
    );
    Test.setMock(HttpCalloutMock.class, mock);
    
    // WHEN
    Test.startTest();
      String result = ExternalSearch.googleIt('epic search');
    Test.stopTest();
    
    // THEN
    System.assertEquals('I found it!', result, 'Expected to receive mock response');
  }
  
  @IsTest
  static void testNegativeMocking() {
    // GIVEN: Mock with HTTP 500 response (internal server error)
    HTTPMockFactory mock = new HTTPMockFactory(
      500,
      'Internal Server Error',
      'Server error occurred',
      new Map<String, String>()
    );
    Test.setMock(HttpCalloutMock.class, mock);
    
    // WHEN & THEN: Expect ExternalSearchException due to status code != 200
    Test.startTest();
      try {
        String result = ExternalSearch.googleIt('fail search');
        System.assert(false, 'Expected ExternalSearchException to be thrown');
      } catch (ExternalSearch.ExternalSearchException e) {
        System.assert(e.getMessage().contains('Did not receive a 200 status code: 500'), 'Expected exception message');
      }
    Test.stopTest();
  }
}
