package itu.p16.finance.service;

import itu.p16.finance.dto.AI21Response;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class AI21Service {

    @Value("${ai21.api.key}")
    private String apiKey;

    private final String AI21_API_URL = "https://api.ai21.com/studio/v1/chat/completions";
    private final RestTemplate restTemplate = new RestTemplate();

    public String getInterpretation(String input) {
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + apiKey);
        headers.set("Content-Type", "application/json");

        String requestBody = String.format("""
            {
                "model": "jamba-1.5-large",
                "messages": [
                    {
                        "role": "user",
                        "content": "%s"
                    }
                ],
                "topP": 1.0
            }
            """, input);

        HttpEntity<String> request = new HttpEntity<>(requestBody, headers);

        try {
            AI21Response response = restTemplate.postForObject(AI21_API_URL, request, AI21Response.class);
            if (response == null || response.getChoices() == null || response.getChoices().length == 0) {
                return "No response received";
            }

            String content = response.getChoices()[0].getMessage().getContent();
            return content != null ? content : "No content in response";
        } catch (Exception e) {
            return "Error getting interpretation: " + e.getMessage();
        }
    }
}