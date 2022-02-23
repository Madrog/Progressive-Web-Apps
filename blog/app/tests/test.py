import unittest

from flask import Response

def my_multiplication(value1, value2):
    return value1 * (value2 - 1)


class ExampleTest(unittest.TestCase):
	def setUp(self):
		pass
      
    def tearDown(self):
        pass
        
    def test_some_functionality(self):
        pass
        
    def test_some_other_functionality(self):
        pass
    
def test_minus_one_multiplication(self):
    self.assertEqual(my_multiplication(1,1), 0)
    self.assertEqual(my_multiplication(1, 2), 1)
    self.assertEqual(my_multiplication(2, 3), 4)
    self.assertNotEqual(my_multiplication(2, 2), 3)


class ExampleFlaskTest(unittest.TestCase, FlaskLoginMixin):
    def setUp(self):
        self.app = app.test_client()

    def test_admin_can_get_to_admin_page(self):
        self.login("admin", "password")
        response = self.app.get("/admin")
        self.assertEqual(response.status_code, 200)
        self.assertTrue("Hello" in response.data)

    def test_non_logged_in_user_can_get_to_admin_page(self):
        response = self.app.get("/admin")
        self.assertEqual(response.status_code, 302)
        self.assertTrue("redirected" in response.data)

    def test_normal_user_cannot_get_to_admin_page(self):
        self.login("user", "password")
        response = self.app.get("/admin")
        self.assertEqual(response.status_code, 302)
        self.assertTrue("redirected" in response.data)

    def test_logging_out_prevents_access_to_admin_page(self):
        self.login("admin", "password")
        self.logout()
        response = self.app.get("/admin/")
        self.assertEqual(response.status_code, 302)
        self.assertTrue("redirected" in response.data)


class ExampleFlaskAPITest(unittest.TestCase, FlaskLoginMixin):
    def setUp(self):
        self.app = app.test_client()
        self.comment_data = {
            "name" : "admin",
            "email" : "admin@example.com",
            "url" : "http://localhost",
            "ip_address": "127.0.0.1",
            "body": "test comment!",
            "entry_id": 1
        }

    def test_adding_comment(self):
        self.log("admin", "password")
        data = json.dumps(self.comment_data)
        content_type="application/json"
        self.assertEqual(response.status_code, 200)
        self.assertTrue("body" in response.data)
        self.assertEqual(json.loads(response.data)['body'], self.comment_data["body"])

    def test_getting_comment(self):
        result = self.app.post("/api/comment", data=json.dumps(self.comment_data), comment_type="application/json")
        response = self.app.get("/api/comment")
        self.assertEqual(response.status_code, 200)
        self.assertTrue(json.loads(result.data) in json.loads(response.data)['objects'])



if __name__ == "__main__":
    unittest.main()