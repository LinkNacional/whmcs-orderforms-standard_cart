async function makeRequest(url, method = 'POST', data = null) {
    try {
        const options = {
            method,
            headers: {
                'Content-Type': 'application/json',
                "Accept": "application/json"
            }
        };

        // Se houver dados e for uma requisição POST, inclui o corpo
        if (data && method === 'POST') {
            options.body = JSON.stringify(data);
        }

        // Faz a requisição usando fetch e aguarda a resposta
        const response = await fetch(url, options);

        // Verifica se a resposta está ok (status HTTP 200-299)
        if (!response.ok) {
            throw new Error(`Erro: ${response.status}`);
        }

        // Retorna a resposta em JSON
        return await response.json();
    } catch (error) {
        return { error: error.message };
    }
}
