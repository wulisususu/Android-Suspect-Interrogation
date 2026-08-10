.class public Lanet/channel/session/b;
.super Ljava/lang/Object;
.source "Taobao"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lanet/channel/session/b$a;
    }
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 57
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static a(Ljava/net/HttpURLConnection;Lanet/channel/request/Request;)I
    .locals 7

    const-string v0, "postData"

    const-string v1, "awcn.HttpConnector"

    .line 387
    invoke-virtual {p1}, Lanet/channel/request/Request;->containsBody()Z

    move-result v2

    const/4 v3, 0x0

    if-eqz v2, :cond_3

    const/4 v2, 0x0

    .line 390
    :try_start_0
    invoke-virtual {p0}, Ljava/net/HttpURLConnection;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v2

    .line 391
    invoke-virtual {p1, v2}, Lanet/channel/request/Request;->postBody(Ljava/io/OutputStream;)I

    move-result p0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v2, :cond_0

    .line 397
    :try_start_1
    invoke-virtual {v2}, Ljava/io/OutputStream;->flush()V

    .line 398
    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :catch_0
    move-exception v2

    .line 400
    invoke-virtual {p1}, Lanet/channel/request/Request;->getSeq()Ljava/lang/String;

    move-result-object v4

    new-array v3, v3, [Ljava/lang/Object;

    invoke-static {v1, v0, v4, v2, v3}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :cond_0
    :goto_0
    move v3, p0

    goto :goto_1

    :catchall_0
    move-exception p0

    goto :goto_2

    :catch_1
    move-exception p0

    :try_start_2
    const-string v4, "postData error"

    .line 393
    invoke-virtual {p1}, Lanet/channel/request/Request;->getSeq()Ljava/lang/String;

    move-result-object v5

    new-array v6, v3, [Ljava/lang/Object;

    invoke-static {v1, v4, v5, p0, v6}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    if-eqz v2, :cond_1

    .line 397
    :try_start_3
    invoke-virtual {v2}, Ljava/io/OutputStream;->flush()V

    .line 398
    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_2

    goto :goto_1

    :catch_2
    move-exception p0

    .line 400
    invoke-virtual {p1}, Lanet/channel/request/Request;->getSeq()Ljava/lang/String;

    move-result-object v2

    new-array v4, v3, [Ljava/lang/Object;

    invoke-static {v1, v0, v2, p0, v4}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    .line 404
    :cond_1
    :goto_1
    iget-object p0, p1, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    int-to-long v0, v3

    iput-wide v0, p0, Lanet/channel/statist/RequestStatistic;->reqBodyInflateSize:J

    .line 405
    iget-object p0, p1, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    iput-wide v0, p0, Lanet/channel/statist/RequestStatistic;->reqBodyDeflateSize:J

    .line 406
    iget-object p0, p1, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    iput-wide v0, p0, Lanet/channel/statist/RequestStatistic;->sendDataSize:J

    goto :goto_4

    :goto_2
    if-eqz v2, :cond_2

    .line 397
    :try_start_4
    invoke-virtual {v2}, Ljava/io/OutputStream;->flush()V

    .line 398
    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_3

    goto :goto_3

    :catch_3
    move-exception v2

    .line 400
    invoke-virtual {p1}, Lanet/channel/request/Request;->getSeq()Ljava/lang/String;

    move-result-object p1

    new-array v3, v3, [Ljava/lang/Object;

    invoke-static {v1, v0, p1, v2, v3}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    .line 403
    :cond_2
    :goto_3
    throw p0

    :cond_3
    :goto_4
    return v3
.end method

.method public static a(Lanet/channel/request/Request;Lanet/channel/RequestCb;)Lanet/channel/session/b$a;
    .locals 21

    move-object/from16 v1, p1

    const-string v2, "Content-Encoding"

    const-string v3, "hostnameVerifier"

    const-string v4, "sslSocketFactory"

    const-string v5, "SSL Error Info."

    const-string v6, "host"

    const-string v7, ""

    const-string v8, "http disconnect"

    const-string v9, "awcn.HttpConnector"

    .line 78
    new-instance v10, Lanet/channel/session/b$a;

    invoke-direct {v10}, Lanet/channel/session/b$a;-><init>()V

    const/4 v11, 0x0

    if-eqz p0, :cond_13

    .line 79
    invoke-virtual/range {p0 .. p0}, Lanet/channel/request/Request;->getUrl()Ljava/net/URL;

    move-result-object v12

    if-nez v12, :cond_0

    goto/16 :goto_13

    :cond_0
    move-object/from16 v12, p0

    move-object v13, v11

    .line 90
    :goto_0
    invoke-static {}, Lanet/channel/status/NetworkStatusHelper;->isConnected()Z

    move-result v14

    if-nez v14, :cond_1

    const/16 v2, -0xc8

    .line 91
    invoke-static {v12, v10, v1, v2, v11}, Lanet/channel/session/b;->a(Lanet/channel/request/Request;Lanet/channel/session/b$a;Lanet/channel/RequestCb;ILjava/lang/Throwable;)V

    goto/16 :goto_10

    :cond_1
    const/4 v15, 0x2

    .line 94
    :try_start_0
    invoke-static {v12}, Lanet/channel/session/b;->a(Lanet/channel/request/Request;)Ljava/net/HttpURLConnection;

    move-result-object v13

    .line 95
    invoke-static {v15}, Lanet/channel/util/ALog;->isPrintLog(I)Z

    move-result v16
    :try_end_0
    .catch Ljava/net/UnknownHostException; {:try_start_0 .. :try_end_0} :catch_1c
    .catch Ljava/net/SocketTimeoutException; {:try_start_0 .. :try_end_0} :catch_1a
    .catch Lorg/apache/http/conn/ConnectTimeoutException; {:try_start_0 .. :try_end_0} :catch_18
    .catch Ljava/net/ConnectException; {:try_start_0 .. :try_end_0} :catch_16
    .catch Ljavax/net/ssl/SSLHandshakeException; {:try_start_0 .. :try_end_0} :catch_14
    .catch Ljavax/net/ssl/SSLException; {:try_start_0 .. :try_end_0} :catch_12
    .catch Ljava/util/concurrent/CancellationException; {:try_start_0 .. :try_end_0} :catch_10
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_e
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_c
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v16, :cond_2

    .line 96
    :try_start_1
    invoke-virtual {v12}, Lanet/channel/request/Request;->getSeq()Ljava/lang/String;

    move-result-object v14

    new-array v11, v15, [Ljava/lang/Object;

    const-string v18, "request URL"

    const/16 v17, 0x0

    aput-object v18, v11, v17

    invoke-virtual {v13}, Ljava/net/HttpURLConnection;->getURL()Ljava/net/URL;

    move-result-object v18

    invoke-virtual/range {v18 .. v18}, Ljava/net/URL;->toString()Ljava/lang/String;

    move-result-object v18

    const/16 v16, 0x1

    aput-object v18, v11, v16

    invoke-static {v9, v7, v14, v11}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 97
    invoke-virtual {v12}, Lanet/channel/request/Request;->getSeq()Ljava/lang/String;

    move-result-object v11

    new-array v14, v15, [Ljava/lang/Object;

    const-string v18, "request Method"

    const/16 v17, 0x0

    aput-object v18, v14, v17

    invoke-virtual {v13}, Ljava/net/HttpURLConnection;->getRequestMethod()Ljava/lang/String;

    move-result-object v18

    const/16 v16, 0x1

    aput-object v18, v14, v16

    invoke-static {v9, v7, v11, v14}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 98
    invoke-virtual {v12}, Lanet/channel/request/Request;->getSeq()Ljava/lang/String;

    move-result-object v11

    new-array v14, v15, [Ljava/lang/Object;

    const-string v18, "request headers"

    const/16 v17, 0x0

    aput-object v18, v14, v17

    invoke-virtual {v13}, Ljava/net/HttpURLConnection;->getRequestProperties()Ljava/util/Map;

    move-result-object v18

    invoke-virtual/range {v18 .. v18}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v18

    const/16 v16, 0x1

    aput-object v18, v14, v16

    invoke-static {v9, v7, v11, v14}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_1
    .catch Ljava/net/UnknownHostException; {:try_start_1 .. :try_end_1} :catch_1c
    .catch Ljava/net/SocketTimeoutException; {:try_start_1 .. :try_end_1} :catch_1a
    .catch Lorg/apache/http/conn/ConnectTimeoutException; {:try_start_1 .. :try_end_1} :catch_18
    .catch Ljava/net/ConnectException; {:try_start_1 .. :try_end_1} :catch_16
    .catch Ljavax/net/ssl/SSLHandshakeException; {:try_start_1 .. :try_end_1} :catch_2
    .catch Ljavax/net/ssl/SSLException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/util/concurrent/CancellationException; {:try_start_1 .. :try_end_1} :catch_10
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_e
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_1

    :catch_0
    move-exception v0

    move-object v2, v0

    move-object/from16 v20, v7

    goto/16 :goto_9

    :catch_1
    move-exception v0

    move-object v2, v0

    move-object/from16 v19, v3

    move-object/from16 v18, v4

    move-object v11, v5

    goto/16 :goto_d

    :catch_2
    move-exception v0

    move-object v2, v0

    move-object/from16 v19, v3

    move-object/from16 v18, v4

    move-object v11, v5

    goto/16 :goto_f

    .line 101
    :cond_2
    :goto_1
    :try_start_2
    iget-object v11, v12, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;
    :try_end_2
    .catch Ljava/net/UnknownHostException; {:try_start_2 .. :try_end_2} :catch_1c
    .catch Ljava/net/SocketTimeoutException; {:try_start_2 .. :try_end_2} :catch_1a
    .catch Lorg/apache/http/conn/ConnectTimeoutException; {:try_start_2 .. :try_end_2} :catch_18
    .catch Ljava/net/ConnectException; {:try_start_2 .. :try_end_2} :catch_16
    .catch Ljavax/net/ssl/SSLHandshakeException; {:try_start_2 .. :try_end_2} :catch_14
    .catch Ljavax/net/ssl/SSLException; {:try_start_2 .. :try_end_2} :catch_12
    .catch Ljava/util/concurrent/CancellationException; {:try_start_2 .. :try_end_2} :catch_10
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_e
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_c
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    move-object v14, v3

    move-object/from16 v18, v4

    :try_start_3
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    iput-wide v3, v11, Lanet/channel/statist/RequestStatistic;->sendStart:J

    .line 102
    iget-object v3, v12, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    iget-object v4, v12, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;
    :try_end_3
    .catch Ljava/net/UnknownHostException; {:try_start_3 .. :try_end_3} :catch_1c
    .catch Ljava/net/SocketTimeoutException; {:try_start_3 .. :try_end_3} :catch_1a
    .catch Lorg/apache/http/conn/ConnectTimeoutException; {:try_start_3 .. :try_end_3} :catch_18
    .catch Ljava/net/ConnectException; {:try_start_3 .. :try_end_3} :catch_16
    .catch Ljavax/net/ssl/SSLHandshakeException; {:try_start_3 .. :try_end_3} :catch_b
    .catch Ljavax/net/ssl/SSLException; {:try_start_3 .. :try_end_3} :catch_a
    .catch Ljava/util/concurrent/CancellationException; {:try_start_3 .. :try_end_3} :catch_10
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_e
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_c
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    move-object v11, v5

    :try_start_4
    iget-wide v4, v4, Lanet/channel/statist/RequestStatistic;->sendStart:J

    iget-object v15, v12, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;
    :try_end_4
    .catch Ljava/net/UnknownHostException; {:try_start_4 .. :try_end_4} :catch_1c
    .catch Ljava/net/SocketTimeoutException; {:try_start_4 .. :try_end_4} :catch_1a
    .catch Lorg/apache/http/conn/ConnectTimeoutException; {:try_start_4 .. :try_end_4} :catch_18
    .catch Ljava/net/ConnectException; {:try_start_4 .. :try_end_4} :catch_16
    .catch Ljavax/net/ssl/SSLHandshakeException; {:try_start_4 .. :try_end_4} :catch_9
    .catch Ljavax/net/ssl/SSLException; {:try_start_4 .. :try_end_4} :catch_8
    .catch Ljava/util/concurrent/CancellationException; {:try_start_4 .. :try_end_4} :catch_10
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_e
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_c
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    move-object/from16 v19, v14

    :try_start_5
    iget-wide v14, v15, Lanet/channel/statist/RequestStatistic;->start:J

    sub-long/2addr v4, v14

    iput-wide v4, v3, Lanet/channel/statist/RequestStatistic;->processTime:J

    .line 103
    invoke-virtual {v13}, Ljava/net/HttpURLConnection;->connect()V

    .line 104
    invoke-static {v13, v12}, Lanet/channel/session/b;->a(Ljava/net/HttpURLConnection;Lanet/channel/request/Request;)I

    .line 107
    iget-object v3, v12, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    iput-wide v4, v3, Lanet/channel/statist/RequestStatistic;->sendEnd:J

    .line 108
    iget-object v3, v12, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    iget-object v4, v12, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    iget-wide v4, v4, Lanet/channel/statist/RequestStatistic;->sendEnd:J

    iget-object v14, v12, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    iget-wide v14, v14, Lanet/channel/statist/RequestStatistic;->sendStart:J

    sub-long/2addr v4, v14

    iput-wide v4, v3, Lanet/channel/statist/RequestStatistic;->sendDataTime:J

    .line 111
    invoke-virtual {v13}, Ljava/net/HttpURLConnection;->getResponseCode()I

    move-result v3

    iput v3, v10, Lanet/channel/session/b$a;->a:I

    .line 112
    invoke-virtual {v13}, Ljava/net/HttpURLConnection;->getHeaderFields()Ljava/util/Map;

    move-result-object v3

    invoke-static {v3}, Lanet/channel/util/HttpHelper;->cloneMap(Ljava/util/Map;)Ljava/util/Map;

    move-result-object v3

    iput-object v3, v10, Lanet/channel/session/b$a;->c:Ljava/util/Map;

    .line 114
    invoke-virtual {v12}, Lanet/channel/request/Request;->getSeq()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x2

    new-array v5, v4, [Ljava/lang/Object;

    const-string v4, "response code"

    const/4 v14, 0x0

    aput-object v4, v5, v14

    iget v4, v10, Lanet/channel/session/b$a;->a:I

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    const/4 v14, 0x1

    aput-object v4, v5, v14

    invoke-static {v9, v7, v3, v5}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 115
    invoke-virtual {v12}, Lanet/channel/request/Request;->getSeq()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x2

    new-array v5, v4, [Ljava/lang/Object;

    const-string v4, "response headers"

    const/4 v14, 0x0

    aput-object v4, v5, v14

    iget-object v4, v10, Lanet/channel/session/b$a;->c:Ljava/util/Map;

    const/4 v14, 0x1

    aput-object v4, v5, v14

    invoke-static {v9, v7, v3, v5}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 117
    iget v3, v10, Lanet/channel/session/b$a;->a:I

    invoke-static {v12, v3}, Lanet/channel/util/HttpHelper;->checkRedirect(Lanet/channel/request/Request;I)Z

    move-result v3

    if-eqz v3, :cond_5

    .line 118
    iget-object v3, v10, Lanet/channel/session/b$a;->c:Ljava/util/Map;

    const-string v4, "Location"

    invoke-static {v3, v4}, Lanet/channel/util/HttpHelper;->getSingleHeaderFieldByKey(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_5

    .line 120
    invoke-static {v3}, Lanet/channel/util/HttpUrl;->parse(Ljava/lang/String;)Lanet/channel/util/HttpUrl;

    move-result-object v4

    if-eqz v4, :cond_4

    const-string v5, "redirect"

    .line 122
    invoke-virtual {v12}, Lanet/channel/request/Request;->getSeq()Ljava/lang/String;

    move-result-object v14
    :try_end_5
    .catch Ljava/net/UnknownHostException; {:try_start_5 .. :try_end_5} :catch_1c
    .catch Ljava/net/SocketTimeoutException; {:try_start_5 .. :try_end_5} :catch_1a
    .catch Lorg/apache/http/conn/ConnectTimeoutException; {:try_start_5 .. :try_end_5} :catch_18
    .catch Ljava/net/ConnectException; {:try_start_5 .. :try_end_5} :catch_16
    .catch Ljavax/net/ssl/SSLHandshakeException; {:try_start_5 .. :try_end_5} :catch_7
    .catch Ljavax/net/ssl/SSLException; {:try_start_5 .. :try_end_5} :catch_6
    .catch Ljava/util/concurrent/CancellationException; {:try_start_5 .. :try_end_5} :catch_10
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_e
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_c
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    move-object/from16 v20, v7

    const/4 v15, 0x2

    :try_start_6
    new-array v7, v15, [Ljava/lang/Object;

    const-string v15, "to url"

    const/16 v17, 0x0

    aput-object v15, v7, v17

    invoke-virtual {v4}, Lanet/channel/util/HttpUrl;->toString()Ljava/lang/String;

    move-result-object v15

    const/16 v16, 0x1

    aput-object v15, v7, v16

    invoke-static {v9, v5, v14, v7}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 123
    invoke-virtual {v12}, Lanet/channel/request/Request;->newBuilder()Lanet/channel/request/Request$Builder;

    move-result-object v5

    const-string v7, "GET"

    .line 124
    invoke-virtual {v5, v7}, Lanet/channel/request/Request$Builder;->setMethod(Ljava/lang/String;)Lanet/channel/request/Request$Builder;

    move-result-object v5

    const/4 v7, 0x0

    .line 125
    invoke-virtual {v5, v7}, Lanet/channel/request/Request$Builder;->setBody(Lanet/channel/request/BodyEntry;)Lanet/channel/request/Request$Builder;

    move-result-object v5

    .line 126
    invoke-virtual {v5, v4}, Lanet/channel/request/Request$Builder;->setUrl(Lanet/channel/util/HttpUrl;)Lanet/channel/request/Request$Builder;

    move-result-object v5

    .line 127
    invoke-virtual {v12}, Lanet/channel/request/Request;->getRedirectTimes()I

    move-result v14

    const/4 v15, 0x1

    add-int/2addr v14, v15

    invoke-virtual {v5, v14}, Lanet/channel/request/Request$Builder;->setRedirectTimes(I)Lanet/channel/request/Request$Builder;

    move-result-object v5

    .line 128
    invoke-virtual {v5, v7}, Lanet/channel/request/Request$Builder;->setSslSocketFactory(Ljavax/net/ssl/SSLSocketFactory;)Lanet/channel/request/Request$Builder;

    move-result-object v5

    .line 129
    invoke-virtual {v5, v7}, Lanet/channel/request/Request$Builder;->setHostnameVerifier(Ljavax/net/ssl/HostnameVerifier;)Lanet/channel/request/Request$Builder;

    move-result-object v5

    .line 130
    invoke-virtual {v5}, Lanet/channel/request/Request$Builder;->build()Lanet/channel/request/Request;

    move-result-object v12

    .line 131
    iget-object v5, v12, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    iget v7, v10, Lanet/channel/session/b$a;->a:I

    invoke-virtual {v4}, Lanet/channel/util/HttpUrl;->simpleUrlString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v5, v7, v4}, Lanet/channel/statist/RequestStatistic;->recordRedirect(ILjava/lang/String;)V

    .line 132
    iget-object v4, v12, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    iput-object v3, v4, Lanet/channel/statist/RequestStatistic;->locationUrl:Ljava/lang/String;
    :try_end_6
    .catch Ljava/net/UnknownHostException; {:try_start_6 .. :try_end_6} :catch_1c
    .catch Ljava/net/SocketTimeoutException; {:try_start_6 .. :try_end_6} :catch_1a
    .catch Lorg/apache/http/conn/ConnectTimeoutException; {:try_start_6 .. :try_end_6} :catch_18
    .catch Ljava/net/ConnectException; {:try_start_6 .. :try_end_6} :catch_16
    .catch Ljavax/net/ssl/SSLHandshakeException; {:try_start_6 .. :try_end_6} :catch_7
    .catch Ljavax/net/ssl/SSLException; {:try_start_6 .. :try_end_6} :catch_6
    .catch Ljava/util/concurrent/CancellationException; {:try_start_6 .. :try_end_6} :catch_10
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_e
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_5
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    if-eqz v13, :cond_3

    .line 244
    :try_start_7
    invoke-virtual {v13}, Ljava/net/HttpURLConnection;->disconnect()V
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_3

    goto :goto_2

    :catch_3
    move-exception v0

    move-object v3, v0

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    .line 247
    invoke-static {v9, v8, v5, v3, v4}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :cond_3
    :goto_2
    move-object v5, v11

    move-object/from16 v4, v18

    move-object/from16 v3, v19

    move-object/from16 v7, v20

    const/4 v11, 0x0

    goto/16 :goto_0

    :cond_4
    move-object/from16 v20, v7

    :try_start_8
    const-string v4, "redirect url is invalid!"

    .line 135
    invoke-virtual {v12}, Lanet/channel/request/Request;->getSeq()Ljava/lang/String;

    move-result-object v5

    const/4 v7, 0x2

    new-array v14, v7, [Ljava/lang/Object;

    const-string v7, "redirect url"

    const/4 v15, 0x0

    aput-object v7, v14, v15

    const/4 v7, 0x1

    aput-object v3, v14, v7

    invoke-static {v9, v4, v5, v14}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_3

    :cond_5
    move-object/from16 v20, v7

    .line 140
    :goto_3
    iget-object v3, v12, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    iget-object v4, v10, Lanet/channel/session/b$a;->c:Ljava/util/Map;

    invoke-static {v4, v2}, Lanet/channel/util/HttpHelper;->getSingleHeaderFieldByKey(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    iput-object v4, v3, Lanet/channel/statist/RequestStatistic;->contentEncoding:Ljava/lang/String;

    .line 141
    iget-object v3, v12, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    iget-object v4, v10, Lanet/channel/session/b$a;->c:Ljava/util/Map;

    const-string v5, "Content-Type"

    invoke-static {v4, v5}, Lanet/channel/util/HttpHelper;->getSingleHeaderFieldByKey(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    iput-object v4, v3, Lanet/channel/statist/RequestStatistic;->contentType:Ljava/lang/String;

    const-string v3, "HEAD"

    .line 144
    invoke-virtual {v12}, Lanet/channel/request/Request;->getMethod()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_9

    iget v3, v10, Lanet/channel/session/b$a;->a:I

    const/16 v4, 0x130

    if-eq v3, v4, :cond_9

    iget v3, v10, Lanet/channel/session/b$a;->a:I

    const/16 v4, 0xcc

    if-eq v3, v4, :cond_9

    iget v3, v10, Lanet/channel/session/b$a;->a:I

    const/16 v4, 0x64

    if-lt v3, v4, :cond_6

    iget v3, v10, Lanet/channel/session/b$a;->a:I

    const/16 v4, 0xc8

    if-ge v3, v4, :cond_6

    goto :goto_4

    .line 155
    :cond_6
    iget-object v3, v10, Lanet/channel/session/b$a;->c:Ljava/util/Map;

    invoke-static {v3}, Lanet/channel/util/HttpHelper;->parseContentLength(Ljava/util/Map;)I

    move-result v3

    iput v3, v10, Lanet/channel/session/b$a;->d:I

    .line 156
    iget-object v3, v12, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    iget v4, v10, Lanet/channel/session/b$a;->d:I

    int-to-long v4, v4

    iput-wide v4, v3, Lanet/channel/statist/RequestStatistic;->contentLength:J

    const-string v3, "gzip"

    .line 157
    iget-object v4, v12, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    iget-object v4, v4, Lanet/channel/statist/RequestStatistic;->contentEncoding:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    iput-boolean v3, v10, Lanet/channel/session/b$a;->e:Z

    .line 158
    iget-boolean v3, v10, Lanet/channel/session/b$a;->e:Z

    if-eqz v3, :cond_7

    .line 159
    iget-object v3, v10, Lanet/channel/session/b$a;->c:Ljava/util/Map;

    invoke-interface {v3, v2}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 160
    iget-object v2, v10, Lanet/channel/session/b$a;->c:Ljava/util/Map;

    const-string v3, "Content-Length"

    invoke-interface {v2, v3}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    :cond_7
    if-eqz v1, :cond_8

    .line 163
    iget v2, v10, Lanet/channel/session/b$a;->a:I

    iget-object v3, v10, Lanet/channel/session/b$a;->c:Ljava/util/Map;

    invoke-interface {v1, v2, v3}, Lanet/channel/RequestCb;->onResponseCode(ILjava/util/Map;)V

    .line 166
    :cond_8
    iget-object v2, v12, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    iput-wide v3, v2, Lanet/channel/statist/RequestStatistic;->rspStart:J

    .line 167
    invoke-static {v13, v12, v10, v1}, Lanet/channel/session/b;->a(Ljava/net/HttpURLConnection;Lanet/channel/request/Request;Lanet/channel/session/b$a;Lanet/channel/RequestCb;)V

    goto :goto_5

    :cond_9
    :goto_4
    if-eqz v1, :cond_a

    .line 149
    iget v2, v10, Lanet/channel/session/b$a;->a:I

    iget-object v3, v10, Lanet/channel/session/b$a;->c:Ljava/util/Map;

    invoke-interface {v1, v2, v3}, Lanet/channel/RequestCb;->onResponseCode(ILjava/util/Map;)V

    .line 152
    :cond_a
    iget-object v2, v12, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    iput-wide v3, v2, Lanet/channel/statist/RequestStatistic;->rspStart:J

    .line 170
    :goto_5
    iget-object v2, v12, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    iget-object v3, v12, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    iget-wide v3, v3, Lanet/channel/statist/RequestStatistic;->rspStart:J

    iget-object v5, v12, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    iget-wide v14, v5, Lanet/channel/statist/RequestStatistic;->sendEnd:J

    sub-long/2addr v3, v14

    iput-wide v3, v2, Lanet/channel/statist/RequestStatistic;->firstDataTime:J

    .line 171
    iget-object v2, v12, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    iget-object v2, v2, Lanet/channel/statist/RequestStatistic;->isDone:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v2
    :try_end_8
    .catch Ljava/net/UnknownHostException; {:try_start_8 .. :try_end_8} :catch_1c
    .catch Ljava/net/SocketTimeoutException; {:try_start_8 .. :try_end_8} :catch_1a
    .catch Lorg/apache/http/conn/ConnectTimeoutException; {:try_start_8 .. :try_end_8} :catch_18
    .catch Ljava/net/ConnectException; {:try_start_8 .. :try_end_8} :catch_16
    .catch Ljavax/net/ssl/SSLHandshakeException; {:try_start_8 .. :try_end_8} :catch_7
    .catch Ljavax/net/ssl/SSLException; {:try_start_8 .. :try_end_8} :catch_6
    .catch Ljava/util/concurrent/CancellationException; {:try_start_8 .. :try_end_8} :catch_10
    .catch Ljava/io/IOException; {:try_start_8 .. :try_end_8} :catch_e
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_8} :catch_5
    .catchall {:try_start_8 .. :try_end_8} :catchall_0

    const-string v3, "SUCCESS"

    if-nez v2, :cond_b

    .line 172
    :try_start_9
    iget-object v2, v12, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    const/4 v4, 0x1

    iput v4, v2, Lanet/channel/statist/RequestStatistic;->ret:I

    .line 173
    iget-object v2, v12, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    iget v4, v10, Lanet/channel/session/b$a;->a:I

    iput v4, v2, Lanet/channel/statist/RequestStatistic;->statusCode:I

    .line 174
    iget-object v2, v12, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    iput-object v3, v2, Lanet/channel/statist/RequestStatistic;->msg:Ljava/lang/String;

    .line 175
    iget-object v2, v12, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    iput-wide v4, v2, Lanet/channel/statist/RequestStatistic;->rspEnd:J

    :cond_b
    if-eqz v1, :cond_c

    .line 179
    iget v2, v10, Lanet/channel/session/b$a;->a:I

    iget-object v4, v12, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    invoke-interface {v1, v2, v3, v4}, Lanet/channel/RequestCb;->onFinish(ILjava/lang/String;Lanet/channel/statist/RequestStatistic;)V
    :try_end_9
    .catch Ljava/net/UnknownHostException; {:try_start_9 .. :try_end_9} :catch_1c
    .catch Ljava/net/SocketTimeoutException; {:try_start_9 .. :try_end_9} :catch_1a
    .catch Lorg/apache/http/conn/ConnectTimeoutException; {:try_start_9 .. :try_end_9} :catch_18
    .catch Ljava/net/ConnectException; {:try_start_9 .. :try_end_9} :catch_16
    .catch Ljavax/net/ssl/SSLHandshakeException; {:try_start_9 .. :try_end_9} :catch_7
    .catch Ljavax/net/ssl/SSLException; {:try_start_9 .. :try_end_9} :catch_6
    .catch Ljava/util/concurrent/CancellationException; {:try_start_9 .. :try_end_9} :catch_10
    .catch Ljava/io/IOException; {:try_start_9 .. :try_end_9} :catch_e
    .catch Ljava/lang/Exception; {:try_start_9 .. :try_end_9} :catch_5
    .catchall {:try_start_9 .. :try_end_9} :catchall_0

    :cond_c
    if-eqz v13, :cond_11

    .line 244
    :try_start_a
    invoke-virtual {v13}, Ljava/net/HttpURLConnection;->disconnect()V
    :try_end_a
    .catch Ljava/lang/Exception; {:try_start_a .. :try_end_a} :catch_4

    goto/16 :goto_10

    :catch_4
    move-exception v0

    move-object v1, v0

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    .line 247
    invoke-static {v9, v8, v3, v1, v2}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    goto/16 :goto_10

    :catch_5
    move-exception v0

    goto :goto_8

    :catch_6
    move-exception v0

    goto/16 :goto_c

    :catch_7
    move-exception v0

    goto/16 :goto_e

    :catch_8
    move-exception v0

    goto :goto_6

    :catch_9
    move-exception v0

    goto :goto_7

    :catch_a
    move-exception v0

    move-object v11, v5

    :goto_6
    move-object/from16 v19, v14

    goto/16 :goto_c

    :catch_b
    move-exception v0

    move-object v11, v5

    :goto_7
    move-object/from16 v19, v14

    goto/16 :goto_e

    :catchall_0
    move-exception v0

    move-object v1, v0

    goto/16 :goto_11

    :catch_c
    move-exception v0

    move-object/from16 v20, v7

    :goto_8
    move-object v2, v0

    .line 232
    :goto_9
    :try_start_b
    invoke-virtual {v2}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_d

    invoke-virtual {v2}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v7

    goto :goto_a

    :cond_d
    move-object/from16 v7, v20

    :goto_a
    const-string v3, "not verified"

    .line 233
    invoke-virtual {v7, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_e

    .line 3016
    sget-object v3, Lanet/channel/strategy/c$a;->a:Lanet/channel/strategy/c;

    .line 234
    invoke-virtual {v12}, Lanet/channel/request/Request;->getHost()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Lanet/channel/strategy/c;->b(Ljava/lang/String;)V

    const/16 v3, -0x193

    .line 235
    invoke-static {v12, v10, v1, v3, v2}, Lanet/channel/session/b;->a(Lanet/channel/request/Request;Lanet/channel/session/b$a;Lanet/channel/RequestCb;ILjava/lang/Throwable;)V

    goto :goto_b

    :cond_e
    const/16 v3, -0x65

    .line 237
    invoke-static {v12, v10, v1, v3, v2}, Lanet/channel/session/b;->a(Lanet/channel/request/Request;Lanet/channel/session/b$a;Lanet/channel/RequestCb;ILjava/lang/Throwable;)V

    :goto_b
    const-string v1, "HTTP Exception"

    .line 239
    invoke-virtual {v12}, Lanet/channel/request/Request;->getSeq()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    new-array v5, v4, [Ljava/lang/Object;

    invoke-static {v9, v1, v3, v2, v5}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_0

    if-eqz v13, :cond_11

    .line 244
    :try_start_c
    invoke-virtual {v13}, Ljava/net/HttpURLConnection;->disconnect()V
    :try_end_c
    .catch Ljava/lang/Exception; {:try_start_c .. :try_end_c} :catch_d

    goto/16 :goto_10

    :catch_d
    move-exception v0

    move-object v1, v0

    new-array v2, v4, [Ljava/lang/Object;

    const/4 v3, 0x0

    .line 247
    invoke-static {v9, v8, v3, v1, v2}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    goto/16 :goto_10

    :catch_e
    move-exception v0

    move-object v2, v0

    const/16 v3, -0x194

    .line 227
    :try_start_d
    invoke-static {v12, v10, v1, v3, v2}, Lanet/channel/session/b;->a(Lanet/channel/request/Request;Lanet/channel/session/b$a;Lanet/channel/RequestCb;ILjava/lang/Throwable;)V

    const-string v1, "IO Exception"

    .line 228
    invoke-virtual {v12}, Lanet/channel/request/Request;->getSeq()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x3

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    aput-object v6, v4, v5

    invoke-virtual {v12}, Lanet/channel/request/Request;->getHost()Ljava/lang/String;

    move-result-object v5

    const/4 v6, 0x1

    aput-object v5, v4, v6

    const/4 v5, 0x2

    aput-object v2, v4, v5

    invoke-static {v9, v1, v3, v4}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 229
    invoke-static {}, Lanet/channel/status/NetworkStatusHelper;->printNetworkDetail()V
    :try_end_d
    .catchall {:try_start_d .. :try_end_d} :catchall_0

    if-eqz v13, :cond_11

    .line 244
    :try_start_e
    invoke-virtual {v13}, Ljava/net/HttpURLConnection;->disconnect()V
    :try_end_e
    .catch Ljava/lang/Exception; {:try_start_e .. :try_end_e} :catch_f

    goto/16 :goto_10

    :catch_f
    move-exception v0

    move-object v1, v0

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    .line 247
    invoke-static {v9, v8, v3, v1, v2}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    goto/16 :goto_10

    :catch_10
    move-exception v0

    move-object v2, v0

    const/16 v3, -0xcc

    .line 223
    :try_start_f
    invoke-static {v12, v10, v1, v3, v2}, Lanet/channel/session/b;->a(Lanet/channel/request/Request;Lanet/channel/session/b$a;Lanet/channel/RequestCb;ILjava/lang/Throwable;)V

    const-string v1, "HTTP Request Cancel"

    .line 224
    invoke-virtual {v12}, Lanet/channel/request/Request;->getSeq()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    new-array v5, v4, [Ljava/lang/Object;

    invoke-static {v9, v1, v3, v2, v5}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V
    :try_end_f
    .catchall {:try_start_f .. :try_end_f} :catchall_0

    if-eqz v13, :cond_11

    .line 244
    :try_start_10
    invoke-virtual {v13}, Ljava/net/HttpURLConnection;->disconnect()V
    :try_end_10
    .catch Ljava/lang/Exception; {:try_start_10 .. :try_end_10} :catch_11

    goto/16 :goto_10

    :catch_11
    move-exception v0

    move-object v1, v0

    new-array v2, v4, [Ljava/lang/Object;

    const/4 v3, 0x0

    .line 247
    invoke-static {v9, v8, v3, v1, v2}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    goto/16 :goto_10

    :catch_12
    move-exception v0

    move-object/from16 v19, v3

    move-object/from16 v18, v4

    move-object v11, v5

    :goto_c
    move-object v2, v0

    .line 2016
    :goto_d
    :try_start_11
    sget-object v3, Lanet/channel/strategy/c$a;->a:Lanet/channel/strategy/c;

    .line 213
    invoke-virtual {v12}, Lanet/channel/request/Request;->getHost()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Lanet/channel/strategy/c;->b(Ljava/lang/String;)V

    const/16 v3, -0x192

    .line 214
    invoke-static {v12, v10, v1, v3, v2}, Lanet/channel/session/b;->a(Lanet/channel/request/Request;Lanet/channel/session/b$a;Lanet/channel/RequestCb;ILjava/lang/Throwable;)V

    const-string v1, "connect SSLException"

    .line 215
    invoke-virtual {v12}, Lanet/channel/request/Request;->getSeq()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x3

    new-array v5, v4, [Ljava/lang/Object;

    const/4 v4, 0x0

    aput-object v6, v5, v4

    invoke-virtual {v12}, Lanet/channel/request/Request;->getHost()Ljava/lang/String;

    move-result-object v4

    const/4 v6, 0x1

    aput-object v4, v5, v6

    const/4 v4, 0x2

    aput-object v2, v5, v4

    invoke-static {v9, v1, v3, v5}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 216
    instance-of v1, v13, Ljavax/net/ssl/HttpsURLConnection;

    if-eqz v1, :cond_f

    .line 217
    move-object v1, v13

    check-cast v1, Ljavax/net/ssl/HttpsURLConnection;

    invoke-virtual {v1}, Ljavax/net/ssl/HttpsURLConnection;->getSSLSocketFactory()Ljavax/net/ssl/SSLSocketFactory;

    move-result-object v1

    .line 218
    move-object v2, v13

    check-cast v2, Ljavax/net/ssl/HttpsURLConnection;

    invoke-virtual {v2}, Ljavax/net/ssl/HttpsURLConnection;->getHostnameVerifier()Ljavax/net/ssl/HostnameVerifier;

    move-result-object v2

    .line 219
    invoke-virtual {v12}, Lanet/channel/request/Request;->getSeq()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x4

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    aput-object v18, v4, v5

    const/4 v5, 0x1

    aput-object v1, v4, v5

    const/4 v1, 0x2

    aput-object v19, v4, v1

    const/4 v1, 0x3

    aput-object v2, v4, v1

    invoke-static {v9, v11, v3, v4}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_11
    .catchall {:try_start_11 .. :try_end_11} :catchall_0

    :cond_f
    if-eqz v13, :cond_11

    .line 244
    :try_start_12
    invoke-virtual {v13}, Ljava/net/HttpURLConnection;->disconnect()V
    :try_end_12
    .catch Ljava/lang/Exception; {:try_start_12 .. :try_end_12} :catch_13

    goto/16 :goto_10

    :catch_13
    move-exception v0

    move-object v1, v0

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    .line 247
    invoke-static {v9, v8, v3, v1, v2}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    goto/16 :goto_10

    :catch_14
    move-exception v0

    move-object/from16 v19, v3

    move-object/from16 v18, v4

    move-object v11, v5

    :goto_e
    move-object v2, v0

    .line 1016
    :goto_f
    :try_start_13
    sget-object v3, Lanet/channel/strategy/c$a;->a:Lanet/channel/strategy/c;

    .line 203
    invoke-virtual {v12}, Lanet/channel/request/Request;->getHost()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Lanet/channel/strategy/c;->b(Ljava/lang/String;)V

    const/16 v3, -0x192

    .line 204
    invoke-static {v12, v10, v1, v3, v2}, Lanet/channel/session/b;->a(Lanet/channel/request/Request;Lanet/channel/session/b$a;Lanet/channel/RequestCb;ILjava/lang/Throwable;)V

    const-string v1, "HTTP Connect SSLHandshakeException"

    .line 205
    invoke-virtual {v12}, Lanet/channel/request/Request;->getSeq()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x3

    new-array v5, v4, [Ljava/lang/Object;

    const/4 v4, 0x0

    aput-object v6, v5, v4

    invoke-virtual {v12}, Lanet/channel/request/Request;->getHost()Ljava/lang/String;

    move-result-object v4

    const/4 v6, 0x1

    aput-object v4, v5, v6

    const/4 v4, 0x2

    aput-object v2, v5, v4

    invoke-static {v9, v1, v3, v5}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 206
    instance-of v1, v13, Ljavax/net/ssl/HttpsURLConnection;

    if-eqz v1, :cond_10

    .line 207
    move-object v1, v13

    check-cast v1, Ljavax/net/ssl/HttpsURLConnection;

    invoke-virtual {v1}, Ljavax/net/ssl/HttpsURLConnection;->getSSLSocketFactory()Ljavax/net/ssl/SSLSocketFactory;

    move-result-object v1

    .line 208
    move-object v2, v13

    check-cast v2, Ljavax/net/ssl/HttpsURLConnection;

    invoke-virtual {v2}, Ljavax/net/ssl/HttpsURLConnection;->getHostnameVerifier()Ljavax/net/ssl/HostnameVerifier;

    move-result-object v2

    .line 209
    invoke-virtual {v12}, Lanet/channel/request/Request;->getSeq()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x4

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    aput-object v18, v4, v5

    const/4 v5, 0x1

    aput-object v1, v4, v5

    const/4 v1, 0x2

    aput-object v19, v4, v1

    const/4 v1, 0x3

    aput-object v2, v4, v1

    invoke-static {v9, v11, v3, v4}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_13
    .catchall {:try_start_13 .. :try_end_13} :catchall_0

    :cond_10
    if-eqz v13, :cond_11

    .line 244
    :try_start_14
    invoke-virtual {v13}, Ljava/net/HttpURLConnection;->disconnect()V
    :try_end_14
    .catch Ljava/lang/Exception; {:try_start_14 .. :try_end_14} :catch_15

    goto/16 :goto_10

    :catch_15
    move-exception v0

    move-object v1, v0

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    .line 247
    invoke-static {v9, v8, v3, v1, v2}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    goto/16 :goto_10

    :catch_16
    move-exception v0

    move-object v2, v0

    const/16 v3, -0x196

    .line 198
    :try_start_15
    invoke-static {v12, v10, v1, v3, v2}, Lanet/channel/session/b;->a(Lanet/channel/request/Request;Lanet/channel/session/b$a;Lanet/channel/RequestCb;ILjava/lang/Throwable;)V

    const-string v1, "HTTP Connect Exception"

    .line 199
    invoke-virtual {v12}, Lanet/channel/request/Request;->getSeq()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    new-array v5, v4, [Ljava/lang/Object;

    invoke-static {v9, v1, v3, v2, v5}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    .line 200
    invoke-static {}, Lanet/channel/status/NetworkStatusHelper;->printNetworkDetail()V
    :try_end_15
    .catchall {:try_start_15 .. :try_end_15} :catchall_0

    if-eqz v13, :cond_11

    .line 244
    :try_start_16
    invoke-virtual {v13}, Ljava/net/HttpURLConnection;->disconnect()V
    :try_end_16
    .catch Ljava/lang/Exception; {:try_start_16 .. :try_end_16} :catch_17

    goto/16 :goto_10

    :catch_17
    move-exception v0

    move-object v1, v0

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    .line 247
    invoke-static {v9, v8, v3, v1, v2}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    goto/16 :goto_10

    :catch_18
    move-exception v0

    move-object v2, v0

    const/16 v3, -0x190

    .line 193
    :try_start_17
    invoke-static {v12, v10, v1, v3, v2}, Lanet/channel/session/b;->a(Lanet/channel/request/Request;Lanet/channel/session/b$a;Lanet/channel/RequestCb;ILjava/lang/Throwable;)V

    const-string v1, "HTTP Connect Timeout"

    .line 194
    invoke-virtual {v12}, Lanet/channel/request/Request;->getSeq()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    new-array v5, v4, [Ljava/lang/Object;

    invoke-static {v9, v1, v3, v2, v5}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    .line 195
    invoke-static {}, Lanet/channel/status/NetworkStatusHelper;->printNetworkDetail()V
    :try_end_17
    .catchall {:try_start_17 .. :try_end_17} :catchall_0

    if-eqz v13, :cond_11

    .line 244
    :try_start_18
    invoke-virtual {v13}, Ljava/net/HttpURLConnection;->disconnect()V
    :try_end_18
    .catch Ljava/lang/Exception; {:try_start_18 .. :try_end_18} :catch_19

    goto :goto_10

    :catch_19
    move-exception v0

    move-object v1, v0

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    .line 247
    invoke-static {v9, v8, v3, v1, v2}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    goto :goto_10

    :catch_1a
    move-exception v0

    move-object v2, v0

    const/16 v3, -0x191

    .line 188
    :try_start_19
    invoke-static {v12, v10, v1, v3, v2}, Lanet/channel/session/b;->a(Lanet/channel/request/Request;Lanet/channel/session/b$a;Lanet/channel/RequestCb;ILjava/lang/Throwable;)V

    const-string v1, "HTTP Socket Timeout"

    .line 189
    invoke-virtual {v12}, Lanet/channel/request/Request;->getSeq()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    new-array v5, v4, [Ljava/lang/Object;

    invoke-static {v9, v1, v3, v2, v5}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    .line 190
    invoke-static {}, Lanet/channel/status/NetworkStatusHelper;->printNetworkDetail()V
    :try_end_19
    .catchall {:try_start_19 .. :try_end_19} :catchall_0

    if-eqz v13, :cond_11

    .line 244
    :try_start_1a
    invoke-virtual {v13}, Ljava/net/HttpURLConnection;->disconnect()V
    :try_end_1a
    .catch Ljava/lang/Exception; {:try_start_1a .. :try_end_1a} :catch_1b

    goto :goto_10

    :catch_1b
    move-exception v0

    move-object v1, v0

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    .line 247
    invoke-static {v9, v8, v3, v1, v2}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    goto :goto_10

    :catch_1c
    move-exception v0

    move-object v2, v0

    const/16 v3, -0x195

    .line 183
    :try_start_1b
    invoke-static {v12, v10, v1, v3, v2}, Lanet/channel/session/b;->a(Lanet/channel/request/Request;Lanet/channel/session/b$a;Lanet/channel/RequestCb;ILjava/lang/Throwable;)V

    const-string v1, "Unknown Host Exception"

    .line 184
    invoke-virtual {v12}, Lanet/channel/request/Request;->getSeq()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x3

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    aput-object v6, v4, v5

    invoke-virtual {v12}, Lanet/channel/request/Request;->getHost()Ljava/lang/String;

    move-result-object v5

    const/4 v6, 0x1

    aput-object v5, v4, v6

    const/4 v5, 0x2

    aput-object v2, v4, v5

    invoke-static {v9, v1, v3, v4}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 185
    invoke-static {}, Lanet/channel/status/NetworkStatusHelper;->printNetworkDetail()V
    :try_end_1b
    .catchall {:try_start_1b .. :try_end_1b} :catchall_0

    if-eqz v13, :cond_11

    .line 244
    :try_start_1c
    invoke-virtual {v13}, Ljava/net/HttpURLConnection;->disconnect()V
    :try_end_1c
    .catch Ljava/lang/Exception; {:try_start_1c .. :try_end_1c} :catch_1d

    goto :goto_10

    :catch_1d
    move-exception v0

    move-object v1, v0

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    .line 247
    invoke-static {v9, v8, v3, v1, v2}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :cond_11
    :goto_10
    return-object v10

    :goto_11
    if-eqz v13, :cond_12

    .line 244
    :try_start_1d
    invoke-virtual {v13}, Ljava/net/HttpURLConnection;->disconnect()V
    :try_end_1d
    .catch Ljava/lang/Exception; {:try_start_1d .. :try_end_1d} :catch_1e

    goto :goto_12

    :catch_1e
    move-exception v0

    move-object v2, v0

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    .line 247
    invoke-static {v9, v8, v4, v2, v3}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    .line 249
    :cond_12
    :goto_12
    throw v1

    :cond_13
    :goto_13
    move-object v4, v11

    if-eqz v1, :cond_14

    const/16 v2, -0x66

    .line 82
    invoke-static {v2}, Lanet/channel/util/ErrorConstant;->getErrMsg(I)Ljava/lang/String;

    move-result-object v3

    new-instance v5, Lanet/channel/statist/RequestStatistic;

    invoke-direct {v5, v4, v4}, Lanet/channel/statist/RequestStatistic;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 81
    invoke-interface {v1, v2, v3, v5}, Lanet/channel/RequestCb;->onFinish(ILjava/lang/String;Lanet/channel/statist/RequestStatistic;)V

    :cond_14
    return-object v10
.end method

.method private static a(Lanet/channel/request/Request;)Ljava/net/HttpURLConnection;
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 284
    invoke-static {}, Lanet/channel/status/NetworkStatusHelper;->getWifiProxy()Landroid/util/Pair;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 287
    new-instance v1, Ljava/net/Proxy;

    sget-object v2, Ljava/net/Proxy$Type;->HTTP:Ljava/net/Proxy$Type;

    new-instance v3, Ljava/net/InetSocketAddress;

    iget-object v4, v0, Landroid/util/Pair;->first:Ljava/lang/Object;

    check-cast v4, Ljava/lang/String;

    iget-object v0, v0, Landroid/util/Pair;->second:Ljava/lang/Object;

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    invoke-direct {v3, v4, v0}, Ljava/net/InetSocketAddress;-><init>(Ljava/lang/String;I)V

    invoke-direct {v1, v2, v3}, Ljava/net/Proxy;-><init>(Ljava/net/Proxy$Type;Ljava/net/SocketAddress;)V

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    .line 290
    :goto_0
    invoke-static {}, Lanet/channel/util/g;->a()Lanet/channel/util/g;

    move-result-object v0

    .line 291
    invoke-static {}, Lanet/channel/status/NetworkStatusHelper;->getStatus()Lanet/channel/status/NetworkStatusHelper$NetworkStatus;

    move-result-object v2

    invoke-virtual {v2}, Lanet/channel/status/NetworkStatusHelper$NetworkStatus;->isMobile()Z

    move-result v2

    if-eqz v2, :cond_1

    if-eqz v0, :cond_1

    .line 292
    invoke-virtual {v0}, Lanet/channel/util/g;->b()Ljava/net/Proxy;

    move-result-object v1

    .line 296
    :cond_1
    invoke-virtual {p0}, Lanet/channel/request/Request;->getUrl()Ljava/net/URL;

    move-result-object v2

    if-eqz v1, :cond_2

    .line 298
    invoke-virtual {v2, v1}, Ljava/net/URL;->openConnection(Ljava/net/Proxy;)Ljava/net/URLConnection;

    move-result-object v1

    check-cast v1, Ljava/net/HttpURLConnection;

    goto :goto_1

    .line 300
    :cond_2
    invoke-virtual {v2}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v1

    check-cast v1, Ljava/net/HttpURLConnection;

    .line 303
    :goto_1
    invoke-virtual {p0}, Lanet/channel/request/Request;->getConnectTimeout()I

    move-result v3

    invoke-virtual {v1, v3}, Ljava/net/HttpURLConnection;->setConnectTimeout(I)V

    .line 304
    invoke-virtual {p0}, Lanet/channel/request/Request;->getReadTimeout()I

    move-result v3

    invoke-virtual {v1, v3}, Ljava/net/HttpURLConnection;->setReadTimeout(I)V

    .line 305
    invoke-virtual {p0}, Lanet/channel/request/Request;->getMethod()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/net/HttpURLConnection;->setRequestMethod(Ljava/lang/String;)V

    .line 306
    invoke-virtual {p0}, Lanet/channel/request/Request;->containsBody()Z

    move-result v3

    if-eqz v3, :cond_3

    const/4 v3, 0x1

    .line 307
    invoke-virtual {v1, v3}, Ljava/net/HttpURLConnection;->setDoOutput(Z)V

    .line 310
    :cond_3
    invoke-virtual {p0}, Lanet/channel/request/Request;->getHeaders()Ljava/util/Map;

    move-result-object v3

    .line 313
    invoke-interface {v3}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v4

    invoke-interface {v4}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_2
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_4

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/util/Map$Entry;

    .line 314
    invoke-interface {v5}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    invoke-interface {v5}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    invoke-virtual {v1, v6, v5}, Ljava/net/HttpURLConnection;->addRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_2

    :cond_4
    const-string v4, "Host"

    .line 318
    invoke-interface {v3, v4}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    if-nez v5, :cond_5

    .line 320
    invoke-virtual {p0}, Lanet/channel/request/Request;->getHost()Ljava/lang/String;

    move-result-object v5

    .line 324
    :cond_5
    invoke-virtual {p0}, Lanet/channel/request/Request;->getHttpUrl()Lanet/channel/util/HttpUrl;

    move-result-object v6

    invoke-virtual {v6}, Lanet/channel/util/HttpUrl;->containsNonDefaultPort()Z

    move-result v6

    if-eqz v6, :cond_6

    .line 325
    invoke-virtual {p0}, Lanet/channel/request/Request;->getHttpUrl()Lanet/channel/util/HttpUrl;

    move-result-object v6

    invoke-virtual {v6}, Lanet/channel/util/HttpUrl;->getPort()I

    move-result v6

    invoke-static {v6}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v6

    const-string v7, ":"

    invoke-static {v5, v7, v6}, Lanet/channel/util/StringUtils;->concatString(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    goto :goto_3

    :cond_6
    move-object v6, v5

    .line 327
    :goto_3
    invoke-virtual {v1, v4, v6}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 328
    invoke-static {}, Lanet/channel/status/NetworkStatusHelper;->getApn()Ljava/lang/String;

    move-result-object v4

    const-string v7, "cmwap"

    invoke-virtual {v4, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_7

    const-string v4, "x-online-host"

    .line 329
    invoke-virtual {v1, v4, v6}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    :cond_7
    const-string v4, "Accept-Encoding"

    .line 333
    invoke-interface {v3, v4}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_8

    const-string v3, "gzip"

    .line 334
    invoke-virtual {v1, v4, v3}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    :cond_8
    if-eqz v0, :cond_9

    const-string v3, "Authorization"

    .line 339
    invoke-virtual {v0}, Lanet/channel/util/g;->c()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v3, v0}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 342
    :cond_9
    invoke-virtual {v2}, Ljava/net/URL;->getProtocol()Ljava/lang/String;

    move-result-object v0

    const-string v2, "https"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_a

    .line 343
    invoke-static {v1, p0, v5}, Lanet/channel/session/b;->a(Ljava/net/HttpURLConnection;Lanet/channel/request/Request;Ljava/lang/String;)V

    :cond_a
    const/4 p0, 0x0

    .line 346
    invoke-virtual {v1, p0}, Ljava/net/HttpURLConnection;->setInstanceFollowRedirects(Z)V

    return-object v1
.end method

.method private static a(Lanet/channel/request/Request;Lanet/channel/session/b$a;Lanet/channel/RequestCb;ILjava/lang/Throwable;)V
    .locals 10

    .line 258
    invoke-static {p3}, Lanet/channel/util/ErrorConstant;->getErrMsg(I)Ljava/lang/String;

    move-result-object v8

    .line 259
    invoke-virtual {p0}, Lanet/channel/request/Request;->getSeq()Ljava/lang/String;

    move-result-object v9

    const-string v0, "errorCode"

    invoke-static {p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "errMsg"

    const-string v4, "url"

    .line 260
    invoke-virtual {p0}, Lanet/channel/request/Request;->getUrlString()Ljava/lang/String;

    move-result-object v5

    const-string v6, "host"

    invoke-virtual {p0}, Lanet/channel/request/Request;->getHost()Ljava/lang/String;

    move-result-object v7

    move-object v3, v8

    filled-new-array/range {v0 .. v7}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "awcn.HttpConnector"

    const-string v2, "onException"

    .line 259
    invoke-static {v1, v2, v9, v0}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    if-eqz p1, :cond_0

    .line 264
    iput p3, p1, Lanet/channel/session/b$a;->a:I

    .line 267
    :cond_0
    iget-object p1, p0, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    iget-object p1, p1, Lanet/channel/statist/RequestStatistic;->isDone:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {p1}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result p1

    if-nez p1, :cond_1

    .line 268
    iget-object p1, p0, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    iput p3, p1, Lanet/channel/statist/RequestStatistic;->statusCode:I

    .line 269
    iget-object p1, p0, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    iput-object v8, p1, Lanet/channel/statist/RequestStatistic;->msg:Ljava/lang/String;

    .line 270
    iget-object p1, p0, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p1, Lanet/channel/statist/RequestStatistic;->rspEnd:J

    const/16 p1, -0xcc

    if-eq p3, p1, :cond_1

    .line 273
    new-instance p1, Lanet/channel/statist/ExceptionStatistic;

    iget-object v0, p0, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    invoke-direct {p1, p3, v8, v0, p4}, Lanet/channel/statist/ExceptionStatistic;-><init>(ILjava/lang/String;Lanet/channel/statist/RequestStatistic;Ljava/lang/Throwable;)V

    .line 274
    invoke-static {}, Lanet/channel/appmonitor/AppMonitor;->getInstance()Lanet/channel/appmonitor/IAppMonitor;

    move-result-object p4

    invoke-interface {p4, p1}, Lanet/channel/appmonitor/IAppMonitor;->commitStat(Lanet/channel/statist/StatObject;)V

    :cond_1
    if-eqz p2, :cond_2

    .line 279
    iget-object p0, p0, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    invoke-interface {p2, p3, v8, p0}, Lanet/channel/RequestCb;->onFinish(ILjava/lang/String;Lanet/channel/statist/RequestStatistic;)V

    :cond_2
    return-void
.end method

.method private static a(Ljava/net/HttpURLConnection;Lanet/channel/request/Request;Lanet/channel/session/b$a;Lanet/channel/RequestCb;)V
    .locals 11
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljava/util/concurrent/CancellationException;
        }
    .end annotation

    .line 413
    invoke-virtual {p0}, Ljava/net/HttpURLConnection;->getURL()Ljava/net/URL;

    move-result-object v0

    invoke-virtual {v0}, Ljava/net/URL;->toString()Ljava/lang/String;

    const/4 v0, 0x0

    const/4 v1, 0x0

    .line 416
    :try_start_0
    invoke-virtual {p0}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object p0
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v2

    .line 418
    instance-of v2, v2, Ljava/io/FileNotFoundException;

    const-string v3, "awcn.HttpConnector"

    if-eqz v2, :cond_0

    .line 419
    invoke-virtual {p1}, Lanet/channel/request/Request;->getSeq()Ljava/lang/String;

    move-result-object v2

    const-string v4, "url"

    invoke-virtual {p1}, Lanet/channel/request/Request;->getUrlString()Ljava/lang/String;

    move-result-object v5

    filled-new-array {v4, v5}, [Ljava/lang/Object;

    move-result-object v4

    const-string v5, "File not found"

    invoke-static {v3, v5, v2, v4}, Lanet/channel/util/ALog;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 422
    :cond_0
    :try_start_1
    invoke-virtual {p0}, Ljava/net/HttpURLConnection;->getErrorStream()Ljava/io/InputStream;

    move-result-object p0
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    :catch_1
    move-exception p0

    .line 424
    invoke-virtual {p1}, Lanet/channel/request/Request;->getSeq()Ljava/lang/String;

    move-result-object v2

    new-array v4, v0, [Ljava/lang/Object;

    const-string v5, "get error stream failed."

    invoke-static {v3, v5, v2, p0, v4}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    move-object p0, v1

    :goto_0
    if-nez p0, :cond_1

    const/16 p0, -0x194

    .line 429
    invoke-static {p1, p2, p3, p0, v1}, Lanet/channel/session/b;->a(Lanet/channel/request/Request;Lanet/channel/session/b$a;Lanet/channel/RequestCb;ILjava/lang/Throwable;)V

    return-void

    :cond_1
    if-nez p3, :cond_4

    .line 436
    iget v2, p2, Lanet/channel/session/b$a;->d:I

    if-gtz v2, :cond_2

    const/16 v2, 0x400

    goto :goto_1

    :cond_2
    iget-boolean v2, p2, Lanet/channel/session/b$a;->e:Z

    if-eqz v2, :cond_3

    iget v2, p2, Lanet/channel/session/b$a;->d:I

    mul-int/lit8 v2, v2, 0x2

    goto :goto_1

    :cond_3
    iget v2, p2, Lanet/channel/session/b$a;->d:I

    .line 438
    :goto_1
    new-instance v3, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v3, v2}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    goto :goto_2

    :cond_4
    move-object v3, v1

    .line 443
    :goto_2
    :try_start_2
    new-instance v2, Lanet/channel/util/a;

    invoke-direct {v2, p0}, Lanet/channel/util/a;-><init>(Ljava/io/InputStream;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 444
    :try_start_3
    iget-boolean v4, p2, Lanet/channel/session/b$a;->e:Z

    if-eqz v4, :cond_5

    .line 445
    new-instance v4, Ljava/util/zip/GZIPInputStream;

    invoke-direct {v4, v2}, Ljava/util/zip/GZIPInputStream;-><init>(Ljava/io/InputStream;)V

    move-object p0, v4

    goto :goto_3

    :cond_5
    move-object p0, v2

    :goto_3
    move-object v4, v1

    .line 453
    :goto_4
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Thread;->isInterrupted()Z

    move-result v5

    if-nez v5, :cond_b

    if-nez v4, :cond_6

    .line 8021
    sget-object v4, Lanet/channel/bytes/a$a;->a:Lanet/channel/bytes/a;

    const/16 v5, 0x800

    .line 457
    invoke-virtual {v4, v5}, Lanet/channel/bytes/a;->a(I)Lanet/channel/bytes/ByteArray;

    move-result-object v4

    .line 459
    :cond_6
    invoke-virtual {v4, p0}, Lanet/channel/bytes/ByteArray;->readFrom(Ljava/io/InputStream;)I

    move-result v5

    const/4 v6, -0x1

    if-eq v5, v6, :cond_8

    if-eqz v3, :cond_7

    .line 462
    invoke-virtual {v4, v3}, Lanet/channel/bytes/ByteArray;->writeTo(Ljava/io/OutputStream;)V

    goto :goto_5

    .line 464
    :cond_7
    invoke-interface {p3, v4, v0}, Lanet/channel/RequestCb;->onDataReceive(Lanet/channel/bytes/ByteArray;Z)V

    move-object v4, v1

    .line 467
    :goto_5
    iget-object v6, p1, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    iget-wide v7, v6, Lanet/channel/statist/RequestStatistic;->recDataSize:J

    int-to-long v9, v5

    add-long/2addr v7, v9

    iput-wide v7, v6, Lanet/channel/statist/RequestStatistic;->recDataSize:J

    .line 468
    iget-object v5, p1, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    iget-wide v6, v5, Lanet/channel/statist/RequestStatistic;->rspBodyInflateSize:J

    add-long/2addr v6, v9

    iput-wide v6, v5, Lanet/channel/statist/RequestStatistic;->rspBodyInflateSize:J

    goto :goto_4

    :cond_8
    if-eqz v3, :cond_9

    .line 471
    invoke-virtual {v4}, Lanet/channel/bytes/ByteArray;->recycle()V

    goto :goto_6

    :cond_9
    const/4 v0, 0x1

    .line 473
    invoke-interface {p3, v4, v0}, Lanet/channel/RequestCb;->onDataReceive(Lanet/channel/bytes/ByteArray;Z)V

    :goto_6
    if-eqz v3, :cond_a

    .line 480
    invoke-virtual {v3}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object p3

    iput-object p3, p2, Lanet/channel/session/b$a;->b:[B
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 483
    :cond_a
    iget-object p2, p1, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget-object p3, p1, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    iget-wide v3, p3, Lanet/channel/statist/RequestStatistic;->rspStart:J

    sub-long/2addr v0, v3

    iput-wide v0, p2, Lanet/channel/statist/RequestStatistic;->recDataTime:J

    .line 484
    iget-object p1, p1, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    invoke-virtual {v2}, Lanet/channel/util/a;->a()J

    move-result-wide p2

    iput-wide p2, p1, Lanet/channel/statist/RequestStatistic;->rspBodyDeflateSize:J

    .line 487
    :try_start_4
    invoke-virtual {p0}, Ljava/io/InputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_2

    :catch_2
    return-void

    .line 454
    :cond_b
    :try_start_5
    new-instance p2, Ljava/util/concurrent/CancellationException;

    const-string p3, "task cancelled"

    invoke-direct {p2, p3}, Ljava/util/concurrent/CancellationException;-><init>(Ljava/lang/String;)V

    throw p2
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    :catchall_0
    move-exception p2

    move-object v1, v2

    goto :goto_7

    :catchall_1
    move-exception p2

    .line 483
    :goto_7
    iget-object p3, p1, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    iget-object v0, p1, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    iget-wide v4, v0, Lanet/channel/statist/RequestStatistic;->rspStart:J

    sub-long/2addr v2, v4

    iput-wide v2, p3, Lanet/channel/statist/RequestStatistic;->recDataTime:J

    .line 484
    iget-object p1, p1, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    invoke-virtual {v1}, Lanet/channel/util/a;->a()J

    move-result-wide v0

    iput-wide v0, p1, Lanet/channel/statist/RequestStatistic;->rspBodyDeflateSize:J

    if-eqz p0, :cond_c

    .line 487
    :try_start_6
    invoke-virtual {p0}, Ljava/io/InputStream;->close()V
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_3

    .line 490
    :catch_3
    :cond_c
    throw p2
.end method

.method private static a(Ljava/net/HttpURLConnection;Lanet/channel/request/Request;Ljava/lang/String;)V
    .locals 6

    .line 352
    sget-object v0, Landroid/os/Build$VERSION;->SDK:Ljava/lang/String;

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    const/16 v1, 0x8

    const-string v2, "awcn.HttpConnector"

    if-ge v0, v1, :cond_0

    const/4 p0, 0x0

    new-array p0, p0, [Ljava/lang/Object;

    const-string p1, "supportHttps"

    const-string p2, "[supportHttps]Froyo \u4ee5\u4e0b\u7248\u672c\u4e0d\u652f\u6301https"

    .line 353
    invoke-static {v2, p1, p2, p0}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void

    .line 356
    :cond_0
    check-cast p0, Ljavax/net/ssl/HttpsURLConnection;

    .line 359
    invoke-virtual {p1}, Lanet/channel/request/Request;->getSslSocketFactory()Ljavax/net/ssl/SSLSocketFactory;

    move-result-object v0

    const-string v1, "HttpSslUtil"

    const/4 v3, 0x2

    if-eqz v0, :cond_1

    .line 360
    invoke-virtual {p1}, Lanet/channel/request/Request;->getSslSocketFactory()Ljavax/net/ssl/SSLSocketFactory;

    move-result-object v0

    invoke-virtual {p0, v0}, Ljavax/net/ssl/HttpsURLConnection;->setSSLSocketFactory(Ljavax/net/ssl/SSLSocketFactory;)V

    goto :goto_0

    .line 3017
    :cond_1
    sget-object v0, Lanet/channel/util/b;->a:Ljavax/net/ssl/SSLSocketFactory;

    if-eqz v0, :cond_2

    .line 4017
    sget-object v0, Lanet/channel/util/b;->a:Ljavax/net/ssl/SSLSocketFactory;

    .line 362
    invoke-virtual {p0, v0}, Ljavax/net/ssl/HttpsURLConnection;->setSSLSocketFactory(Ljavax/net/ssl/SSLSocketFactory;)V

    .line 363
    invoke-static {v3}, Lanet/channel/util/ALog;->isPrintLog(I)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 364
    invoke-virtual {p1}, Lanet/channel/request/Request;->getSeq()Ljava/lang/String;

    move-result-object v0

    const-string v4, "SslSocketFactory"

    .line 5017
    sget-object v5, Lanet/channel/util/b;->a:Ljavax/net/ssl/SSLSocketFactory;

    .line 364
    filled-new-array {v4, v5}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v2, v1, v0, v4}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 368
    :cond_2
    :goto_0
    invoke-virtual {p1}, Lanet/channel/request/Request;->getHostnameVerifier()Ljavax/net/ssl/HostnameVerifier;

    move-result-object v0

    if-eqz v0, :cond_3

    .line 369
    invoke-virtual {p1}, Lanet/channel/request/Request;->getHostnameVerifier()Ljavax/net/ssl/HostnameVerifier;

    move-result-object p1

    invoke-virtual {p0, p1}, Ljavax/net/ssl/HttpsURLConnection;->setHostnameVerifier(Ljavax/net/ssl/HostnameVerifier;)V

    goto :goto_1

    .line 5025
    :cond_3
    sget-object v0, Lanet/channel/util/b;->b:Ljavax/net/ssl/HostnameVerifier;

    if-eqz v0, :cond_4

    .line 6025
    sget-object p2, Lanet/channel/util/b;->b:Ljavax/net/ssl/HostnameVerifier;

    .line 371
    invoke-virtual {p0, p2}, Ljavax/net/ssl/HttpsURLConnection;->setHostnameVerifier(Ljavax/net/ssl/HostnameVerifier;)V

    .line 372
    invoke-static {v3}, Lanet/channel/util/ALog;->isPrintLog(I)Z

    move-result p0

    if-eqz p0, :cond_5

    .line 373
    invoke-virtual {p1}, Lanet/channel/request/Request;->getSeq()Ljava/lang/String;

    move-result-object p0

    const-string p1, "HostnameVerifier"

    .line 7025
    sget-object p2, Lanet/channel/util/b;->b:Ljavax/net/ssl/HostnameVerifier;

    .line 373
    filled-new-array {p1, p2}, [Ljava/lang/Object;

    move-result-object p1

    invoke-static {v2, v1, p0, p1}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_1

    .line 376
    :cond_4
    new-instance p1, Lanet/channel/session/c;

    invoke-direct {p1, p2}, Lanet/channel/session/c;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0, p1}, Ljavax/net/ssl/HttpsURLConnection;->setHostnameVerifier(Ljavax/net/ssl/HostnameVerifier;)V

    :cond_5
    :goto_1
    return-void
.end method
