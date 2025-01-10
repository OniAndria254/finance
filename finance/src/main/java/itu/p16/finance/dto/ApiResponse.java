package itu.p16.finance.dto;

public class ApiResponse {
    private String result;
    private String error;

    public ApiResponse(String result, String error) {
        this.result = result;
        this.error = error;
    }

    public String getResult() {
        return result;
    }

    public String getError() {
        return error;
    }
}