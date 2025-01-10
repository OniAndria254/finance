package itu.p16.finance.dto;

public class Message {
    private String role;
    private String content;
    private Object toolCalls;

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Object getToolCalls() {
        return toolCalls;
    }

    public void setToolCalls(Object toolCalls) {
        this.toolCalls = toolCalls;
    }
}