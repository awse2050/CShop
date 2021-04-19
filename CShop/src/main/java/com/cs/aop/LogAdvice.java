package com.cs.aop;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

@Aspect
@Component
public class LogAdvice {
	
	@Around( "execution(* com.cs.service.*.*(..))")
	public Object logExecutionTime(ProceedingJoinPoint joinPoint) throws Throwable {

		long time = System.currentTimeMillis();
		
	    Object proceed = joinPoint.proceed();

	    System.out.println(" Execute To " +joinPoint.getSignature() + "executed.. " + (System.currentTimeMillis() - time));
	    return proceed;
	}
}
