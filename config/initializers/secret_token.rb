# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
require 'securerandom'

def secure_token
	token_file = Rails.root.join('.secret')
	if File.exist?(token_file)
		# Use the existing token.
		File.read(token_file).chomp
	else
		# Generate a new token and store it in token_file.
		token = SecureRandom.hex(64)
		File.write(token_file, token)
		token		
	end
end

SampleApp::Application.config.secret_key_base = secure_token
#SampleApp::Application.config.secret_key_base = 'dbb522c46877ace2ab0236e33888b806a0a26c6fe20efb426605454c9bd3b5d1dd9a3579c3f2827c0548f50481f957c9f9b392dd8f970ce87b1340bf8e4dfe66'
