package com.ysd.websocket;



import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
 
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;  
import javax.websocket.server.ServerEndpoint;  
 
@ServerEndpoint("/websocket/{username}")  
public class SocketTest {  
  
    private static int onlineCount = 0;  
    private static Map<String, SocketTest> clients = new ConcurrentHashMap<>();  
    private Session session;  
    private String username;  
      
    @OnOpen  
    public void onOpen(@PathParam("username") String username, Session session) throws IOException {  
    	
        this.username = username;  
        this.session = session;  
          
        addOnlineCount();  
        clients.put(username, this);
    }  
  
    @OnClose  
    public void onClose() throws IOException {  
        clients.remove(username);  
        subOnlineCount();  
    }  
  
    @OnMessage  
    public void onMessage(String message) throws IOException {  
    	String[] split = message.split(",");
		String formName=split[0];
		String tomName=split[1];
		String content=split[2];
		if(clients.containsKey(tomName)) {
			//李四在线
			clients.get(tomName).session.getAsyncRemote().sendText(content);
		}else {
			//离线消息
		}
    }  
  
    @OnError  
    public void onError(Session session, Throwable error) {  
        error.printStackTrace();  
    }  
  
    public void sendMessageTo(String message, String To) throws IOException {  
        // session.getBasicRemote().sendText(message);  
        //session.getAsyncRemote().sendText(message);  
        for (SocketTest item : clients.values()) {  
            if (item.username.equals(To) )  
                item.session.getAsyncRemote().sendText(message);  
        }  
    }  
      
    public void sendMessageAll(String message) throws IOException {  
        for (SocketTest item : clients.values()) {  
            item.session.getAsyncRemote().sendText(message);  
        }  
    }  
      
      
  
    public static synchronized int getOnlineCount() {  
        return onlineCount;  
    }  
  
    public static synchronized void addOnlineCount() {  
    	SocketTest.onlineCount++;  
    }  
  
    public static synchronized void subOnlineCount() {  
    	SocketTest.onlineCount--;  
    }  
  
    public static synchronized Map<String, SocketTest> getClients() {  
        return clients;  
    }  
}