# Overview

## SQL Server 2016 Supports the following encryption standards:

- AES_128
- AES_192
- AES_256

## Alogrithms that should no longer be used:

- DES
- Triple_DES
- Triple_DES_3Key
- DESX
- RC2
- RC4
- RC4_128

## Consideration with encryption

- Encrypted Data cannot be compressed. Compression should be applied first, and then encryption.
- Encrypted Data cannot be sorted, indexed, or searched
- Space allocation and schemas will need to be altered
- Encryption is CPU intensive
- You should condider using symmetric keys with asymmetric encryption
