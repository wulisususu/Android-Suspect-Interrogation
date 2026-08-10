.class public Lcom/alibaba/sdk/android/tbrest/rest/a;
.super Ljava/lang/Object;
.source "RestHttpUtils.java"


# direct methods
.method public static a(ILjava/lang/String;Ljava/util/Map;Z)[B
    .locals 16
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;Z)[B"
        }
    .end annotation

    move/from16 v1, p0

    move-object/from16 v2, p2

    const-string v3, "write out error!"

    const-string v4, "connection error!"

    const-string v5, "out close error!"

    .line 64
    invoke-static/range {p1 .. p1}, Lcom/alibaba/sdk/android/tbrest/utils/StringUtils;->isEmpty(Ljava/lang/String;)Z

    move-result v0

    const/4 v6, 0x0

    if-eqz v0, :cond_0

    return-object v6

    .line 70
    :cond_0
    :try_start_0
    new-instance v0, Ljava/net/URL;
    :try_end_0
    .catch Ljava/net/MalformedURLException; {:try_start_0 .. :try_end_0} :catch_11
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_10

    move-object/from16 v7, p1

    :try_start_1
    invoke-direct {v0, v7}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    .line 71
    invoke-virtual {v0}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v0

    move-object v7, v0

    check-cast v7, Ljava/net/HttpURLConnection;
    :try_end_1
    .catch Ljava/net/MalformedURLException; {:try_start_1 .. :try_end_1} :catch_f
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_10

    if-eqz v7, :cond_1b

    const/4 v0, 0x1

    const/4 v8, 0x3

    const/4 v9, 0x2

    if-eq v1, v9, :cond_1

    if-ne v1, v8, :cond_2

    .line 83
    :cond_1
    invoke-virtual {v7, v0}, Ljava/net/HttpURLConnection;->setDoOutput(Z)V

    .line 85
    :cond_2
    invoke-virtual {v7, v0}, Ljava/net/HttpURLConnection;->setDoInput(Z)V

    if-eq v1, v9, :cond_4

    if-ne v1, v8, :cond_3

    goto :goto_0

    :cond_3
    :try_start_2
    const-string v10, "GET"

    .line 91
    invoke-virtual {v7, v10}, Ljava/net/HttpURLConnection;->setRequestMethod(Ljava/lang/String;)V

    goto :goto_1

    :cond_4
    :goto_0
    const-string v10, "POST"

    .line 89
    invoke-virtual {v7, v10}, Ljava/net/HttpURLConnection;->setRequestMethod(Ljava/lang/String;)V
    :try_end_2
    .catch Ljava/net/ProtocolException; {:try_start_2 .. :try_end_2} :catch_e

    :goto_1
    const/4 v4, 0x0

    .line 97
    invoke-virtual {v7, v4}, Ljava/net/HttpURLConnection;->setUseCaches(Z)V

    const/16 v10, 0x2710

    .line 98
    invoke-virtual {v7, v10}, Ljava/net/HttpURLConnection;->setConnectTimeout(I)V

    const v10, 0xea60

    .line 99
    invoke-virtual {v7, v10}, Ljava/net/HttpURLConnection;->setReadTimeout(I)V

    const-string v10, "Connection"

    const-string v11, "close"

    .line 100
    invoke-virtual {v7, v10, v11}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    if-eqz p3, :cond_5

    const-string v10, "Accept-Encoding"

    const-string v11, "gzip,deflate"

    .line 102
    invoke-virtual {v7, v10, v11}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 104
    :cond_5
    invoke-virtual {v7, v0}, Ljava/net/HttpURLConnection;->setInstanceFollowRedirects(Z)V

    if-eq v1, v9, :cond_7

    if-ne v1, v8, :cond_6

    goto :goto_2

    :cond_6
    move-object v0, v6

    goto/16 :goto_9

    :cond_7
    :goto_2
    const-string v10, "Content-Type"

    if-ne v1, v9, :cond_8

    const-string v11, "multipart/form-data; boundary=GJircTeP"

    .line 112
    invoke-virtual {v7, v10, v11}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_3

    :cond_8
    if-ne v1, v8, :cond_9

    const-string v11, "application/x-www-form-urlencoded"

    .line 115
    invoke-virtual {v7, v10, v11}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    :cond_9
    :goto_3
    if-eqz v2, :cond_f

    .line 119
    invoke-interface/range {p2 .. p2}, Ljava/util/Map;->size()I

    move-result v10

    if-lez v10, :cond_f

    .line 120
    new-instance v10, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v10}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 121
    invoke-interface/range {p2 .. p2}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v11

    .line 123
    invoke-interface {v11}, Ljava/util/Set;->size()I

    move-result v12

    new-array v12, v12, [Ljava/lang/String;

    .line 124
    invoke-interface {v11, v12}, Ljava/util/Set;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    .line 126
    invoke-static {}, Lcom/alibaba/sdk/android/tbrest/rest/b;->a()Lcom/alibaba/sdk/android/tbrest/rest/b;

    move-result-object v11

    invoke-virtual {v11, v12, v0}, Lcom/alibaba/sdk/android/tbrest/rest/b;->a([Ljava/lang/String;Z)[Ljava/lang/String;

    move-result-object v11

    .line 128
    array-length v12, v11

    move v13, v4

    :goto_4
    const-string v14, "write lBaos error!"

    if-ge v13, v12, :cond_d

    aget-object v0, v11, v13

    if-ne v1, v9, :cond_a

    .line 130
    invoke-interface {v2, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v15

    check-cast v15, [B

    if-eqz v15, :cond_c

    :try_start_3
    const-string v6, "--GJircTeP\r\nContent-Disposition: form-data; name=\"%s\"; filename=\"%s\"\r\nContent-Type: application/octet-stream \r\n\r\n"

    .line 133
    filled-new-array {v0, v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v6, v0}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    invoke-virtual {v10, v0}, Ljava/io/ByteArrayOutputStream;->write([B)V

    .line 134
    invoke-virtual {v10, v15}, Ljava/io/ByteArrayOutputStream;->write([B)V

    const-string v0, "\r\n"

    .line 135
    invoke-virtual {v0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    invoke-virtual {v10, v0}, Ljava/io/ByteArrayOutputStream;->write([B)V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_0

    goto :goto_5

    :catch_0
    move-exception v0

    .line 137
    invoke-static {v14, v0}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_5

    :cond_a
    if-ne v1, v8, :cond_c

    .line 141
    invoke-interface {v2, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    .line 142
    invoke-virtual {v10}, Ljava/io/ByteArrayOutputStream;->size()I

    move-result v15

    const-string v4, "="

    if-lez v15, :cond_b

    .line 144
    :try_start_4
    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "&"

    invoke-virtual {v15, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    invoke-virtual {v10, v0}, Ljava/io/ByteArrayOutputStream;->write([B)V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_1

    goto :goto_5

    :catch_1
    move-exception v0

    .line 146
    invoke-static {v14, v0}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_5

    .line 150
    :cond_b
    :try_start_5
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v8, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    invoke-virtual {v10, v0}, Ljava/io/ByteArrayOutputStream;->write([B)V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_2

    goto :goto_5

    :catch_2
    move-exception v0

    .line 152
    invoke-static {v14, v0}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    :cond_c
    :goto_5
    add-int/lit8 v13, v13, 0x1

    const/4 v4, 0x0

    const/4 v6, 0x0

    const/4 v8, 0x3

    goto/16 :goto_4

    :cond_d
    if-ne v1, v9, :cond_e

    :try_start_6
    const-string v0, "--GJircTeP--\r\n"

    .line 159
    invoke-virtual {v0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    invoke-virtual {v10, v0}, Ljava/io/ByteArrayOutputStream;->write([B)V
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_3

    goto :goto_6

    :catch_3
    move-exception v0

    .line 162
    invoke-static {v14, v0}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 164
    :cond_e
    :goto_6
    invoke-virtual {v10}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v0

    goto :goto_7

    :cond_f
    const/4 v0, 0x0

    :goto_7
    if-eqz v0, :cond_10

    .line 167
    array-length v2, v0

    goto :goto_8

    :cond_10
    const/4 v2, 0x0

    :goto_8
    const-string v4, "Content-Length"

    .line 169
    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v7, v4, v2}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 175
    :goto_9
    :try_start_7
    invoke-virtual {v7}, Ljava/net/HttpURLConnection;->connect()V

    if-eq v1, v9, :cond_11

    const/4 v2, 0x3

    if-ne v1, v2, :cond_12

    :cond_11
    if-eqz v0, :cond_12

    .line 177
    array-length v1, v0

    if-lez v1, :cond_12

    .line 180
    new-instance v1, Ljava/io/DataOutputStream;

    invoke-virtual {v7}, Ljava/net/HttpURLConnection;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/io/DataOutputStream;-><init>(Ljava/io/OutputStream;)V
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_b
    .catchall {:try_start_7 .. :try_end_7} :catchall_2

    .line 181
    :try_start_8
    invoke-virtual {v1, v0}, Ljava/io/DataOutputStream;->write([B)V

    .line 182
    invoke-virtual {v1}, Ljava/io/DataOutputStream;->flush()V
    :try_end_8
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_8} :catch_4
    .catchall {:try_start_8 .. :try_end_8} :catchall_3

    goto :goto_a

    :catch_4
    move-exception v0

    goto/16 :goto_13

    :cond_12
    const/4 v1, 0x0

    :goto_a
    if-eqz v1, :cond_13

    .line 190
    :try_start_9
    invoke-virtual {v1}, Ljava/io/DataOutputStream;->close()V
    :try_end_9
    .catch Ljava/io/IOException; {:try_start_9 .. :try_end_9} :catch_5

    goto :goto_b

    :catch_5
    move-exception v0

    move-object v1, v0

    .line 192
    invoke-static {v5, v1}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 200
    :cond_13
    :goto_b
    new-instance v1, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v1}, Ljava/io/ByteArrayOutputStream;-><init>()V

    if-eqz p3, :cond_14

    :try_start_a
    const-string v0, "gzip"

    .line 202
    invoke-virtual {v7}, Ljava/net/HttpURLConnection;->getContentEncoding()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_14

    .line 203
    new-instance v0, Ljava/util/zip/GZIPInputStream;

    invoke-virtual {v7}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v2

    invoke-direct {v0, v2}, Ljava/util/zip/GZIPInputStream;-><init>(Ljava/io/InputStream;)V

    goto :goto_c

    .line 205
    :cond_14
    new-instance v0, Ljava/io/DataInputStream;

    invoke-virtual {v7}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v2

    invoke-direct {v0, v2}, Ljava/io/DataInputStream;-><init>(Ljava/io/InputStream;)V
    :try_end_a
    .catch Ljava/io/IOException; {:try_start_a .. :try_end_a} :catch_8
    .catchall {:try_start_a .. :try_end_a} :catchall_0

    :goto_c
    move-object v2, v0

    const/16 v0, 0x800

    :try_start_b
    new-array v4, v0, [B

    const/4 v6, 0x0

    .line 209
    :goto_d
    invoke-virtual {v2, v4, v6, v0}, Ljava/io/InputStream;->read([BII)I

    move-result v7

    const/4 v8, -0x1

    if-eq v7, v8, :cond_15

    .line 210
    invoke-virtual {v1, v4, v6, v7}, Ljava/io/ByteArrayOutputStream;->write([BII)V
    :try_end_b
    .catch Ljava/io/IOException; {:try_start_b .. :try_end_b} :catch_7
    .catchall {:try_start_b .. :try_end_b} :catchall_1

    goto :goto_d

    .line 218
    :cond_15
    :try_start_c
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_c
    .catch Ljava/lang/Exception; {:try_start_c .. :try_end_c} :catch_6

    goto :goto_e

    :catch_6
    move-exception v0

    move-object v2, v0

    .line 220
    invoke-static {v5, v2}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 225
    :goto_e
    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->size()I

    move-result v0

    if-lez v0, :cond_16

    .line 226
    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v0

    return-object v0

    :cond_16
    const/4 v1, 0x0

    return-object v1

    :catch_7
    move-exception v0

    goto :goto_f

    :catchall_0
    move-exception v0

    move-object v1, v0

    const/4 v6, 0x0

    goto :goto_11

    :catch_8
    move-exception v0

    const/4 v2, 0x0

    .line 213
    :goto_f
    :try_start_d
    invoke-static {v3, v0}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->e(Ljava/lang/String;Ljava/lang/Throwable;)V
    :try_end_d
    .catchall {:try_start_d .. :try_end_d} :catchall_1

    if-eqz v2, :cond_17

    .line 218
    :try_start_e
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_e
    .catch Ljava/lang/Exception; {:try_start_e .. :try_end_e} :catch_9

    goto :goto_10

    :catch_9
    move-exception v0

    move-object v1, v0

    .line 220
    invoke-static {v5, v1}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    :cond_17
    :goto_10
    const/4 v1, 0x0

    return-object v1

    :catchall_1
    move-exception v0

    move-object v1, v0

    move-object v6, v2

    :goto_11
    if-eqz v6, :cond_18

    .line 218
    :try_start_f
    invoke-virtual {v6}, Ljava/io/InputStream;->close()V
    :try_end_f
    .catch Ljava/lang/Exception; {:try_start_f .. :try_end_f} :catch_a

    goto :goto_12

    :catch_a
    move-exception v0

    move-object v2, v0

    .line 220
    invoke-static {v5, v2}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 223
    :cond_18
    :goto_12
    throw v1

    :catchall_2
    move-exception v0

    move-object v1, v0

    const/4 v6, 0x0

    goto :goto_15

    :catch_b
    move-exception v0

    const/4 v1, 0x0

    .line 185
    :goto_13
    :try_start_10
    invoke-static {v3, v0}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->e(Ljava/lang/String;Ljava/lang/Throwable;)V
    :try_end_10
    .catchall {:try_start_10 .. :try_end_10} :catchall_3

    if-eqz v1, :cond_19

    .line 190
    :try_start_11
    invoke-virtual {v1}, Ljava/io/DataOutputStream;->close()V
    :try_end_11
    .catch Ljava/io/IOException; {:try_start_11 .. :try_end_11} :catch_c

    goto :goto_14

    :catch_c
    move-exception v0

    move-object v1, v0

    .line 192
    invoke-static {v5, v1}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    :cond_19
    :goto_14
    const/4 v1, 0x0

    return-object v1

    :catchall_3
    move-exception v0

    move-object v6, v1

    move-object v1, v0

    :goto_15
    if-eqz v6, :cond_1a

    .line 190
    :try_start_12
    invoke-virtual {v6}, Ljava/io/DataOutputStream;->close()V
    :try_end_12
    .catch Ljava/io/IOException; {:try_start_12 .. :try_end_12} :catch_d

    goto :goto_16

    :catch_d
    move-exception v0

    move-object v2, v0

    .line 192
    invoke-static {v5, v2}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 195
    :cond_1a
    :goto_16
    throw v1

    :catch_e
    move-exception v0

    .line 94
    invoke-static {v4, v0}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    :goto_17
    const/4 v1, 0x0

    return-object v1

    :cond_1b
    move-object v1, v6

    return-object v1

    :catch_f
    move-exception v0

    const/4 v1, 0x0

    goto :goto_18

    :catch_10
    move-exception v0

    .line 76
    invoke-static {v4, v0}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_17

    :catch_11
    move-exception v0

    move-object v1, v6

    .line 73
    :goto_18
    invoke-static {v4, v0}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    return-object v1
.end method
