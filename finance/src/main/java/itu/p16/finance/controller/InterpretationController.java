package itu.p16.finance.controller;

import itu.p16.finance.dto.InterpretationRequest;
import itu.p16.finance.service.AI21Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;


@RestController
@RequestMapping("/api/interpretations")
public class InterpretationController {
    private static final Logger logger = LoggerFactory.getLogger(InterpretationController.class);

    @Autowired
    private AI21Service ai21Service;

    @PostMapping(consumes = MediaType.APPLICATION_JSON_VALUE)
    public String getInterpretation(@RequestBody InterpretationRequest request) {
        logger.info("Received request with text: {}", request.getText());
        if (request.getText() == null || request.getText().isEmpty()) {
            throw new IllegalArgumentException("Text cannot be empty");
        }
        return ai21Service.getInterpretation(request.getText());
    }
}