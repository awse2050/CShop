package com.cs.service;

import com.cs.util.EmailForm;

public interface EmailSendService {

	public boolean sendEmailToUser(EmailForm emailForm);
	
}
