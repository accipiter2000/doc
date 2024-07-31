package com.opendynamic;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.apache.commons.lang3.StringUtils;

public class OdSessionListener implements HttpSessionListener {
    private static HashMap<String, HttpSession> sessionMap;

    static {
        sessionMap = new HashMap<>();
    }

    public void sessionCreated(HttpSessionEvent httpSessionEvent) {
        HttpSession session = httpSessionEvent.getSession();
        if (session != null) {
            sessionMap.put(session.getId(), session);
        }
    }

    public void sessionDestroyed(HttpSessionEvent httpSessionEvent) {
        HttpSession session = httpSessionEvent.getSession();
        if (session != null) {
            sessionMap.remove(session.getId());
        }
    }

    public static HttpSession getSession(String sessionId) {
        return sessionMap.get(sessionId);
    }

    public static int countSession() {
        return sessionMap.size();
    }

    public static HttpSession getSessionByToken(String token) {
        for (Map.Entry<String, HttpSession> entry : sessionMap.entrySet()) {
            if (StringUtils.isNotEmpty(token) && token.equals(entry.getValue().getAttribute("token"))) {
                return entry.getValue();
            }
        }

        return null;
    }
}