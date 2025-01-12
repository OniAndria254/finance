<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>AI21 Interpretation</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        textarea {
            width: 100%;
            min-height: 100px;
            margin-bottom: 10px;
            padding: 8px;
        }
        button {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
        }
        #result {
            margin-top: 20px;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            white-space: pre-wrap;
        }
        .loading {
            color: #666;
            font-style: italic;
        }
        .error {
            color: red;
        }
    </style>
</head>
<body>
<h2>AI21 Interpretation</h2>

<div class="form-group">
    <textarea id="inputText" placeholder="Enter your text here..."></textarea>
</div>

<button onclick="getInterpretation()">Get Interpretation</button>

<div id="result" style="display: none;"></div>

<script>
    function getInterpretation() {
        const text = document.getElementById('inputText').value;
        const resultDiv = document.getElementById('result');

        if (!text) {
            alert('Please enter some text');
            return;
        }

        // Afficher le message de chargement
        resultDiv.style.display = 'block';
        resultDiv.innerHTML = '<p class="loading">Loading...</p>';

        fetch('/api/interpretations', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ text: text })
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                console.log('Response data:', data); // Pour le débogage
                resultDiv.innerHTML = ''; // Effacer le contenu précédent

                if (data.error) {
                    const errorParagraph = document.createElement('p');
                    errorParagraph.className = 'error';
                    errorParagraph.textContent = `Error: ${data.error}`;
                    resultDiv.appendChild(errorParagraph);
                } else if (data.result) {
                    const titleParagraph = document.createElement('p');
                    const resultParagraph = document.createElement('p');

                    titleParagraph.innerHTML = '<strong>AI Response:</strong>';
                    resultParagraph.textContent = data.result;

                    resultDiv.appendChild(titleParagraph);
                    resultDiv.appendChild(resultParagraph);
                } else {
                    const noResponseParagraph = document.createElement('p');
                    noResponseParagraph.className = 'error';
                    noResponseParagraph.textContent = 'No response received';
                    resultDiv.appendChild(noResponseParagraph);
                }
            })
            .catch(error => {
                console.error('Error:', error); // Pour le débogage
                resultDiv.innerHTML = ''; // Effacer le contenu précédent
                const errorParagraph = document.createElement('p');
                errorParagraph.className = 'error';
                errorParagraph.textContent = `Error: ${error.message}`;
                resultDiv.appendChild(errorParagraph);
            });
    }

</script>
</body>
</html>