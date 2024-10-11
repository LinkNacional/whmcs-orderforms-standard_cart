function maskCPF(value) {
    const cpfArr = value.replace(/\D/g, '').split('');
    const resultArr = [];

    for (let c = 0; c < cpfArr.length; c++) {
        resultArr.push(cpfArr[c]);

        if (c === 2 || c === 5) {
            resultArr.push('.');
        } else if (c === 8) {
            resultArr.push('-');
        }
    }

    const cpfMasked = resultArr.join('');
    return cpfMasked;
}

function maskCNPJ(value) {
    const cnpjArr = value.replace(/\D/g, '').split('');
    const resultArr = [];

    for (let c = 0; c < cnpjArr.length; c++) {
        resultArr.push(cnpjArr[c]);

        if (c === 1 || c === 4) {
            resultArr.push('.');
        } else if (c === 7) {
            resultArr.push('/');
        } else if (c === 11) {
            resultArr.push('-');
        }
    }

    const cnpjMasked = resultArr.join('');
    return cnpjMasked;
}


function maskNIF(nif) {
    // Remove caracteres não numéricos
    nif = nif.replace(/\D/g, '');

    // Verifica se o NIF tem exatamente 9 dígitos
    if (nif.length === 9) {
        return nif; // Retorna o NIF formatado
    } else {
        throw new Error('O NIF deve ter 9 dígitos.');
    }
}