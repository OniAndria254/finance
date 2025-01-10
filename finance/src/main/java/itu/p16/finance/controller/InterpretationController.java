package itu.p16.finance.controller;


import itu.p16.finance.service.AI21Service;
import itu.p16.finance.dto.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.http.MediaType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@RestController
@RequestMapping("/api/interpretations")
@CrossOrigin
public class InterpretationController {
    private static final Logger logger = LoggerFactory.getLogger(InterpretationController.class);

    @Autowired
    private AI21Service ai21Service;

    @PostMapping(consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<ApiResponse> getInterpretation(@RequestBody InterpretationRequest request) {
        try {
            logger.info("Received request with text: {}", request.getText());

            if (request.getText() == null || request.getText().isEmpty()) {
                return ResponseEntity.badRequest()
                        .body(new ApiResponse(null, "Text cannot be empty"));
            }

            String result = ai21Service.getInterpretation(request.getText());
            if (result == null || result.isEmpty()) {
                return ResponseEntity.ok(new ApiResponse(null, "No response received"));
            }
            return ResponseEntity.ok(new ApiResponse(result, null));

        } catch (Exception e) {
            logger.error("Error processing request", e);
            return ResponseEntity.internalServerError()
                    .body(new ApiResponse(null, "Error processing request: " + e.getMessage()));
        }
    }
}