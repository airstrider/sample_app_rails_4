Feature: Signing in
	Scenario: Unsuccessfule signin
		Given an user visits the signin page
		When the user submits invalid signin information
		Then the user should see an error message

	Scenario: Successful signin
		Given the user has an account
		When the user submits valid signin information
		Then the user should see his_her profile page
		Then the user should see a signout link