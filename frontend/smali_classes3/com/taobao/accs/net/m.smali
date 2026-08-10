.class Lcom/taobao/accs/net/m;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field final synthetic a:Lcom/taobao/accs/data/Message;

.field final synthetic b:Lcom/taobao/accs/net/j;


# direct methods
.method constructor <init>(Lcom/taobao/accs/net/j;Lcom/taobao/accs/data/Message;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/accs/net/m;->b:Lcom/taobao/accs/net/j;

    iput-object p2, p0, Lcom/taobao/accs/net/m;->a:Lcom/taobao/accs/data/Message;

    .line 153
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 23

    move-object/from16 v1, p0

    const-string v2, "sendMessage"

    const-string v0, "type"

    const-string v3, "accs"

    const-string v4, "status"

    const-string v5, "sendMessage end"

    const-string v6, "dataId"

    iget-object v7, v1, Lcom/taobao/accs/net/m;->a:Lcom/taobao/accs/data/Message;

    if-eqz v7, :cond_10

    .line 157
    invoke-virtual {v7}, Lcom/taobao/accs/data/Message;->e()Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;

    move-result-object v7

    if-eqz v7, :cond_0

    iget-object v7, v1, Lcom/taobao/accs/net/m;->a:Lcom/taobao/accs/data/Message;

    .line 158
    invoke-virtual {v7}, Lcom/taobao/accs/data/Message;->e()Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;

    move-result-object v7

    invoke-virtual {v7}, Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;->onTakeFromQueue()V

    .line 161
    :cond_0
    sget-object v7, Lcom/taobao/accs/AccsErrorCode;->SUCCESS:Lcom/alibaba/sdk/android/error/ErrorCode;

    iget-object v8, v1, Lcom/taobao/accs/net/m;->a:Lcom/taobao/accs/data/Message;

    .line 162
    invoke-virtual {v8}, Lcom/taobao/accs/data/Message;->a()I

    move-result v8

    const/4 v9, 0x1

    :try_start_0
    iget-object v10, v1, Lcom/taobao/accs/net/m;->b:Lcom/taobao/accs/net/j;

    .line 164
    invoke-static {v10}, Lcom/taobao/accs/net/j;->a(Lcom/taobao/accs/net/j;)Lcom/alibaba/sdk/android/logger/ILog;

    move-result-object v10

    const/4 v11, 0x5

    new-array v12, v11, [Ljava/lang/Object;

    const-string v13, "sendMessage start"

    const/4 v14, 0x0

    aput-object v13, v12, v14

    aput-object v6, v12, v9

    iget-object v13, v1, Lcom/taobao/accs/net/m;->a:Lcom/taobao/accs/data/Message;

    iget-object v13, v13, Lcom/taobao/accs/data/Message;->q:Ljava/lang/String;

    const/4 v15, 0x2

    aput-object v13, v12, v15

    const/4 v13, 0x3

    aput-object v0, v12, v13

    .line 165
    invoke-static {v8}, Lcom/taobao/accs/data/Message$c;->b(I)Ljava/lang/String;

    move-result-object v16

    const/16 v17, 0x4

    aput-object v16, v12, v17

    .line 164
    invoke-interface {v10, v12}, Lcom/alibaba/sdk/android/logger/ILog;->d([Ljava/lang/Object;)V

    if-ne v8, v9, :cond_a

    iget-object v0, v1, Lcom/taobao/accs/net/m;->a:Lcom/taobao/accs/data/Message;

    .line 167
    iget-object v0, v0, Lcom/taobao/accs/data/Message;->f:Ljava/net/URL;

    if-nez v0, :cond_1

    iget-object v0, v1, Lcom/taobao/accs/net/m;->b:Lcom/taobao/accs/net/j;

    .line 168
    iget-object v0, v0, Lcom/taobao/accs/net/j;->e:Lcom/taobao/accs/data/d;

    iget-object v11, v1, Lcom/taobao/accs/net/m;->a:Lcom/taobao/accs/data/Message;

    sget-object v12, Lcom/taobao/accs/AccsErrorCode;->MESSAGE_HOST_NULL:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v0, v11, v12}, Lcom/taobao/accs/data/d;->a(Lcom/taobao/accs/data/Message;Lcom/alibaba/sdk/android/error/ErrorCode;)V

    :goto_0
    move v14, v9

    goto/16 :goto_6

    :cond_1
    iget-object v0, v1, Lcom/taobao/accs/net/m;->b:Lcom/taobao/accs/net/j;

    .line 171
    iget-object v0, v0, Lcom/taobao/accs/net/j;->i:Lcom/taobao/accs/AccsClientConfig;

    .line 172
    invoke-virtual {v0}, Lcom/taobao/accs/AccsClientConfig;->getAppKey()Ljava/lang/String;

    move-result-object v0

    .line 171
    invoke-static {v0}, Lanet/channel/SessionCenter;->getInstance(Ljava/lang/String;)Lanet/channel/SessionCenter;

    move-result-object v0

    iget-object v12, v1, Lcom/taobao/accs/net/m;->b:Lcom/taobao/accs/net/j;

    iget-object v10, v1, Lcom/taobao/accs/net/m;->a:Lcom/taobao/accs/data/Message;

    .line 173
    iget-object v10, v10, Lcom/taobao/accs/data/Message;->f:Ljava/net/URL;

    invoke-virtual {v10}, Ljava/net/URL;->getHost()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v12, v0, v10, v14}, Lcom/taobao/accs/net/j;->a(Lanet/channel/SessionCenter;Ljava/lang/String;Z)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    :try_start_1
    iget-object v10, v1, Lcom/taobao/accs/net/m;->a:Lcom/taobao/accs/data/Message;

    .line 177
    iget-object v10, v10, Lcom/taobao/accs/data/Message;->f:Ljava/net/URL;

    .line 178
    invoke-virtual {v10}, Ljava/net/URL;->toString()Ljava/lang/String;

    move-result-object v10

    sget-object v12, Lanet/channel/entity/ConnType$TypeLevel;->SPDY:Lanet/channel/entity/ConnType$TypeLevel;

    const-wide/32 v13, 0xea60

    .line 177
    invoke-virtual {v0, v10, v12, v13, v14}, Lanet/channel/SessionCenter;->getThrowsException(Ljava/lang/String;Lanet/channel/entity/ConnType$TypeLevel;J)Lanet/channel/Session;

    move-result-object v0
    :try_end_1
    .catch Ljava/security/InvalidParameterException; {:try_start_1 .. :try_end_1} :catch_3
    .catch Ljava/util/concurrent/TimeoutException; {:try_start_1 .. :try_end_1} :catch_2
    .catch Ljava/net/ConnectException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Lanet/channel/NoAvailStrategyException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto/16 :goto_2

    :catchall_0
    move-exception v0

    :try_start_2
    iget-object v7, v1, Lcom/taobao/accs/net/m;->b:Lcom/taobao/accs/net/j;

    .line 198
    iget-object v7, v7, Lcom/taobao/accs/net/j;->d:Landroid/content/Context;

    invoke-static {v7}, Lcom/taobao/accs/utl/UtilityImpl;->g(Landroid/content/Context;)Z

    move-result v7

    if-eqz v7, :cond_2

    .line 199
    sget-object v7, Lcom/taobao/accs/AccsErrorCode;->NETWORK_INAPP_EXCEPTION:Lcom/alibaba/sdk/android/error/ErrorCode;

    .line 200
    invoke-virtual {v7}, Lcom/alibaba/sdk/android/error/ErrorCode;->copy()Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v7

    .line 201
    invoke-static {v0}, Lcom/taobao/accs/AccsErrorCode;->getExceptionInfo(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v0

    .line 200
    invoke-static {v0}, Lcom/taobao/accs/AccsErrorCode;->getAllDetails(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v7, v0}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->detail(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v0

    .line 201
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v7

    goto :goto_1

    .line 203
    :cond_2
    sget-object v7, Lcom/taobao/accs/AccsErrorCode;->NO_NETWORK:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v7}, Lcom/alibaba/sdk/android/error/ErrorCode;->copy()Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v7

    .line 204
    invoke-static {v0}, Lcom/taobao/accs/AccsErrorCode;->getExceptionInfo(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v0

    .line 203
    invoke-virtual {v7, v0}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->detail(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v0

    .line 204
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v7

    goto :goto_1

    :catch_0
    move-exception v0

    .line 194
    sget-object v7, Lcom/taobao/accs/AccsErrorCode;->NETWORK_INAPP_NO_STRATEGY:Lcom/alibaba/sdk/android/error/ErrorCode;

    .line 195
    invoke-virtual {v7}, Lcom/alibaba/sdk/android/error/ErrorCode;->copy()Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v7

    invoke-virtual {v0}, Lanet/channel/NoAvailStrategyException;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v7, v0}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->detail(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v7

    goto :goto_1

    :catch_1
    move-exception v0

    .line 188
    sget-object v7, Lcom/taobao/accs/AccsErrorCode;->NETWORK_INAPP_CONNECT_FAIL:Lcom/alibaba/sdk/android/error/ErrorCode;

    .line 189
    invoke-virtual {v7}, Lcom/alibaba/sdk/android/error/ErrorCode;->copy()Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v7

    .line 190
    invoke-virtual {v0}, Ljava/net/ConnectException;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/taobao/accs/AccsErrorCode;->getAllDetails(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 189
    invoke-virtual {v7, v0}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->detail(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v0

    .line 191
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v7

    goto :goto_1

    :catch_2
    move-exception v0

    .line 184
    sget-object v7, Lcom/taobao/accs/AccsErrorCode;->NETWORK_INAPP_TIMEOUT:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v7}, Lcom/alibaba/sdk/android/error/ErrorCode;->copy()Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v7

    .line 185
    invoke-virtual {v0}, Ljava/util/concurrent/TimeoutException;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/taobao/accs/AccsErrorCode;->getAllDetails(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v7, v0}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->detail(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v0

    .line 186
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v7

    goto :goto_1

    :catch_3
    move-exception v0

    .line 181
    sget-object v7, Lcom/taobao/accs/AccsErrorCode;->NETWORK_INAPP_ARGS_INVALID:Lcom/alibaba/sdk/android/error/ErrorCode;

    .line 182
    invoke-virtual {v7}, Lcom/alibaba/sdk/android/error/ErrorCode;->copy()Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v7

    invoke-virtual {v0}, Ljava/security/InvalidParameterException;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v7, v0}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->detail(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v7

    :goto_1
    const/4 v0, 0x0

    :goto_2
    if-eqz v0, :cond_8

    iget-object v10, v1, Lcom/taobao/accs/net/m;->a:Lcom/taobao/accs/data/Message;

    iget-object v12, v1, Lcom/taobao/accs/net/m;->b:Lcom/taobao/accs/net/j;

    .line 209
    iget-object v12, v12, Lcom/taobao/accs/net/j;->d:Landroid/content/Context;

    iget-object v13, v1, Lcom/taobao/accs/net/m;->b:Lcom/taobao/accs/net/j;

    iget v13, v13, Lcom/taobao/accs/net/j;->c:I

    invoke-virtual {v10, v12, v13}, Lcom/taobao/accs/data/Message;->a(Landroid/content/Context;I)[B

    move-result-object v10

    iget-object v12, v1, Lcom/taobao/accs/net/m;->b:Lcom/taobao/accs/net/j;

    .line 210
    invoke-static {v12}, Lcom/taobao/accs/net/j;->a(Lcom/taobao/accs/net/j;)Lcom/alibaba/sdk/android/logger/ILog;

    move-result-object v12

    const/16 v13, 0xb

    new-array v13, v13, [Ljava/lang/Object;

    const/4 v14, 0x0

    aput-object v2, v13, v14

    aput-object v6, v13, v9

    iget-object v14, v1, Lcom/taobao/accs/net/m;->a:Lcom/taobao/accs/data/Message;

    invoke-virtual {v14}, Lcom/taobao/accs/data/Message;->b()Ljava/lang/String;

    move-result-object v14

    aput-object v14, v13, v15

    const-string v14, "command"

    const/4 v15, 0x3

    aput-object v14, v13, v15

    iget-object v14, v1, Lcom/taobao/accs/net/m;->a:Lcom/taobao/accs/data/Message;

    iget-object v14, v14, Lcom/taobao/accs/data/Message;->t:Ljava/lang/Integer;

    aput-object v14, v13, v17

    const-string v14, "host"

    aput-object v14, v13, v11

    iget-object v11, v1, Lcom/taobao/accs/net/m;->a:Lcom/taobao/accs/data/Message;

    iget-object v11, v11, Lcom/taobao/accs/data/Message;->f:Ljava/net/URL;

    const/4 v14, 0x6

    aput-object v11, v13, v14

    const-string v11, "len"

    const/4 v14, 0x7

    aput-object v11, v13, v14

    if-nez v10, :cond_3

    const/4 v14, 0x0

    goto :goto_3

    :cond_3
    array-length v14, v10

    .line 212
    :goto_3
    invoke-static {v14}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v11

    const/16 v14, 0x8

    aput-object v11, v13, v14

    const-string v11, "utdid"

    const/16 v14, 0x9

    aput-object v11, v13, v14

    iget-object v11, v1, Lcom/taobao/accs/net/m;->b:Lcom/taobao/accs/net/j;

    iget-object v11, v11, Lcom/taobao/accs/net/j;->j:Ljava/lang/String;

    const/16 v14, 0xa

    aput-object v11, v13, v14

    .line 210
    invoke-interface {v12, v13}, Lcom/alibaba/sdk/android/logger/ILog;->i([Ljava/lang/Object;)V

    iget-object v11, v1, Lcom/taobao/accs/net/m;->a:Lcom/taobao/accs/data/Message;

    .line 214
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v12

    invoke-virtual {v11, v12, v13}, Lcom/taobao/accs/data/Message;->a(J)V

    .line 215
    array-length v11, v10

    const/16 v12, 0x4000

    if-le v11, v12, :cond_4

    iget-object v11, v1, Lcom/taobao/accs/net/m;->a:Lcom/taobao/accs/data/Message;

    iget-object v11, v11, Lcom/taobao/accs/data/Message;->t:Ljava/lang/Integer;

    invoke-virtual {v11}, Ljava/lang/Integer;->intValue()I

    move-result v11

    const/16 v12, 0x66

    if-eq v11, v12, :cond_4

    iget-object v0, v1, Lcom/taobao/accs/net/m;->b:Lcom/taobao/accs/net/j;

    .line 217
    iget-object v0, v0, Lcom/taobao/accs/net/j;->e:Lcom/taobao/accs/data/d;

    iget-object v10, v1, Lcom/taobao/accs/net/m;->a:Lcom/taobao/accs/data/Message;

    sget-object v11, Lcom/taobao/accs/AccsErrorCode;->MESSAGE_TOO_LARGE:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v0, v10, v11}, Lcom/taobao/accs/data/d;->a(Lcom/taobao/accs/data/Message;Lcom/alibaba/sdk/android/error/ErrorCode;)V

    goto/16 :goto_0

    :cond_4
    iget-object v11, v1, Lcom/taobao/accs/net/m;->b:Lcom/taobao/accs/net/j;

    .line 220
    iget-object v11, v11, Lcom/taobao/accs/net/j;->e:Lcom/taobao/accs/data/d;

    iget-object v12, v1, Lcom/taobao/accs/net/m;->a:Lcom/taobao/accs/data/Message;

    invoke-virtual {v11, v12}, Lcom/taobao/accs/data/d;->a(Lcom/taobao/accs/data/Message;)V

    iget-object v11, v1, Lcom/taobao/accs/net/m;->a:Lcom/taobao/accs/data/Message;

    .line 221
    iget-boolean v11, v11, Lcom/taobao/accs/data/Message;->c:Z

    if-eqz v11, :cond_5

    iget-object v11, v1, Lcom/taobao/accs/net/m;->a:Lcom/taobao/accs/data/Message;

    invoke-virtual {v11}, Lcom/taobao/accs/data/Message;->d()Lcom/taobao/accs/data/Message$a;

    move-result-object v11

    .line 222
    invoke-virtual {v11}, Lcom/taobao/accs/data/Message$a;->a()I

    move-result v11

    neg-int v11, v11

    goto :goto_4

    :cond_5
    iget-object v11, v1, Lcom/taobao/accs/net/m;->a:Lcom/taobao/accs/data/Message;

    invoke-virtual {v11}, Lcom/taobao/accs/data/Message;->d()Lcom/taobao/accs/data/Message$a;

    move-result-object v11

    invoke-virtual {v11}, Lcom/taobao/accs/data/Message$a;->a()I

    move-result v11

    :goto_4
    iget-object v12, v1, Lcom/taobao/accs/net/m;->a:Lcom/taobao/accs/data/Message;

    .line 223
    iget-boolean v12, v12, Lcom/taobao/accs/data/Message;->c:Z

    if-eqz v12, :cond_6

    iget-object v12, v1, Lcom/taobao/accs/net/m;->b:Lcom/taobao/accs/net/j;

    .line 224
    iget-object v12, v12, Lcom/taobao/accs/net/j;->l:Ljava/util/LinkedHashMap;

    invoke-static {v11}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v13

    iget-object v14, v1, Lcom/taobao/accs/net/m;->a:Lcom/taobao/accs/data/Message;

    invoke-virtual {v12, v13, v14}, Ljava/util/LinkedHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 226
    :cond_6
    invoke-static {}, Lcom/taobao/accs/AccsState;->getInstance()Lcom/taobao/accs/AccsState;

    move-result-object v12

    iget-object v13, v1, Lcom/taobao/accs/net/m;->b:Lcom/taobao/accs/net/j;

    iget-object v13, v13, Lcom/taobao/accs/net/j;->m:Ljava/lang/String;

    const-string v14, "lmst"

    .line 227
    invoke-static {v11}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v15

    .line 226
    invoke-virtual {v12, v13, v14, v15}, Lcom/taobao/accs/AccsState;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)V

    const/16 v12, 0xc8

    .line 228
    invoke-virtual {v0, v11, v10, v12}, Lanet/channel/Session;->sendCustomFrame(I[BI)V

    iget-object v0, v1, Lcom/taobao/accs/net/m;->a:Lcom/taobao/accs/data/Message;

    .line 229
    invoke-virtual {v0}, Lcom/taobao/accs/data/Message;->e()Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;

    move-result-object v0

    if-eqz v0, :cond_7

    iget-object v0, v1, Lcom/taobao/accs/net/m;->a:Lcom/taobao/accs/data/Message;

    .line 230
    invoke-virtual {v0}, Lcom/taobao/accs/data/Message;->e()Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;->onSendData()V

    :cond_7
    iget-object v0, v1, Lcom/taobao/accs/net/m;->b:Lcom/taobao/accs/net/j;

    iget-object v11, v1, Lcom/taobao/accs/net/m;->a:Lcom/taobao/accs/data/Message;

    .line 232
    invoke-virtual {v11}, Lcom/taobao/accs/data/Message;->b()Ljava/lang/String;

    move-result-object v11

    iget-object v12, v1, Lcom/taobao/accs/net/m;->b:Lcom/taobao/accs/net/j;

    iget-object v12, v12, Lcom/taobao/accs/net/j;->i:Lcom/taobao/accs/AccsClientConfig;

    .line 233
    invoke-virtual {v12}, Lcom/taobao/accs/AccsClientConfig;->isQuickReconnect()Z

    move-result v12

    iget-object v13, v1, Lcom/taobao/accs/net/m;->a:Lcom/taobao/accs/data/Message;

    iget v13, v13, Lcom/taobao/accs/data/Message;->S:I

    int-to-long v13, v13

    .line 232
    invoke-virtual {v0, v11, v12, v13, v14}, Lcom/taobao/accs/net/j;->a(Ljava/lang/String;ZJ)V

    iget-object v0, v1, Lcom/taobao/accs/net/m;->b:Lcom/taobao/accs/net/j;

    .line 234
    iget-object v0, v0, Lcom/taobao/accs/net/j;->e:Lcom/taobao/accs/data/d;

    new-instance v11, Lcom/taobao/accs/ut/monitor/TrafficsMonitor$a;

    iget-object v12, v1, Lcom/taobao/accs/net/m;->a:Lcom/taobao/accs/data/Message;

    iget-object v12, v12, Lcom/taobao/accs/data/Message;->H:Ljava/lang/String;

    .line 236
    invoke-static {}, Lanet/channel/GlobalAppRuntimeInfo;->isAppBackground()Z

    move-result v19

    iget-object v13, v1, Lcom/taobao/accs/net/m;->a:Lcom/taobao/accs/data/Message;

    iget-object v13, v13, Lcom/taobao/accs/data/Message;->f:Ljava/net/URL;

    .line 237
    invoke-virtual {v13}, Ljava/net/URL;->toString()Ljava/lang/String;

    move-result-object v20

    array-length v10, v10

    int-to-long v13, v10

    move-object/from16 v17, v11

    move-object/from16 v18, v12

    move-wide/from16 v21, v13

    invoke-direct/range {v17 .. v22}, Lcom/taobao/accs/ut/monitor/TrafficsMonitor$a;-><init>(Ljava/lang/String;ZLjava/lang/String;J)V

    .line 234
    invoke-virtual {v0, v11}, Lcom/taobao/accs/data/d;->a(Lcom/taobao/accs/ut/monitor/TrafficsMonitor$a;)V

    goto/16 :goto_0

    .line 240
    :cond_8
    invoke-virtual {v7}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v0

    sget-object v10, Lcom/taobao/accs/AccsErrorCode;->SUCCESS:Lcom/alibaba/sdk/android/error/ErrorCode;

    .line 241
    invoke-virtual {v10}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v10
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    const-string v11, "re"

    if-eq v0, v10, :cond_9

    :try_start_3
    iget-object v0, v1, Lcom/taobao/accs/net/m;->b:Lcom/taobao/accs/net/j;

    .line 242
    invoke-static {v0}, Lcom/taobao/accs/net/j;->a(Lcom/taobao/accs/net/j;)Lcom/alibaba/sdk/android/logger/ILog;

    move-result-object v0

    invoke-virtual {v7}, Lcom/alibaba/sdk/android/error/ErrorCode;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-interface {v0, v10}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;)V

    .line 243
    invoke-static {}, Lcom/taobao/accs/AccsState;->getInstance()Lcom/taobao/accs/AccsState;

    move-result-object v0

    iget-object v10, v1, Lcom/taobao/accs/net/m;->b:Lcom/taobao/accs/net/j;

    iget-object v10, v10, Lcom/taobao/accs/net/j;->m:Ljava/lang/String;

    .line 245
    invoke-virtual {v7}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v12

    invoke-static {v12}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v12

    .line 243
    invoke-virtual {v0, v10, v11, v12}, Lcom/taobao/accs/AccsState;->b(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)V

    goto :goto_5

    :cond_9
    iget-object v0, v1, Lcom/taobao/accs/net/m;->b:Lcom/taobao/accs/net/j;

    .line 247
    invoke-static {v0}, Lcom/taobao/accs/net/j;->a(Lcom/taobao/accs/net/j;)Lcom/alibaba/sdk/android/logger/ILog;

    move-result-object v0

    const-string v10, "sendMessage session is null"

    invoke-interface {v0, v10}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;)V

    .line 248
    invoke-static {}, Lcom/taobao/accs/AccsState;->getInstance()Lcom/taobao/accs/AccsState;

    move-result-object v0

    iget-object v10, v1, Lcom/taobao/accs/net/m;->b:Lcom/taobao/accs/net/j;

    iget-object v10, v10, Lcom/taobao/accs/net/j;->m:Ljava/lang/String;

    const-string v12, "send session null"

    invoke-virtual {v0, v10, v11, v12}, Lcom/taobao/accs/AccsState;->b(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)V

    :goto_5
    const/4 v14, 0x0

    goto :goto_6

    :cond_a
    iget-object v10, v1, Lcom/taobao/accs/net/m;->b:Lcom/taobao/accs/net/j;

    .line 256
    invoke-static {v10}, Lcom/taobao/accs/net/j;->a(Lcom/taobao/accs/net/j;)Lcom/alibaba/sdk/android/logger/ILog;

    move-result-object v10

    const/4 v11, 0x3

    new-array v11, v11, [Ljava/lang/Object;

    const-string v12, "sendMessage skip"

    const/4 v13, 0x0

    aput-object v12, v11, v13

    aput-object v0, v11, v9

    invoke-static {v8}, Lcom/taobao/accs/data/Message$c;->b(I)Ljava/lang/String;

    move-result-object v0

    aput-object v0, v11, v15

    invoke-interface {v10, v11}, Lcom/alibaba/sdk/android/logger/ILog;->w([Ljava/lang/Object;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    goto/16 :goto_0

    :goto_6
    if-nez v14, :cond_f

    .line 266
    invoke-virtual {v7}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v0

    sget-object v2, Lcom/taobao/accs/AccsErrorCode;->SUCCESS:Lcom/alibaba/sdk/android/error/ErrorCode;

    .line 267
    invoke-virtual {v2}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v2

    if-ne v0, v2, :cond_b

    .line 268
    sget-object v0, Lcom/taobao/accs/AccsErrorCode;->INAPP_CON_DISCONNECTED:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorCode;->copy()Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v0

    const/4 v2, 0x0

    .line 269
    invoke-static {v2}, Lcom/taobao/accs/AccsErrorCode;->getAllDetails(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->detail(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v7

    :cond_b
    if-ne v8, v9, :cond_e

    iget-object v0, v1, Lcom/taobao/accs/net/m;->a:Lcom/taobao/accs/data/Message;

    .line 272
    invoke-virtual {v0}, Lcom/taobao/accs/data/Message;->g()Z

    move-result v0

    if-nez v0, :cond_c

    iget-object v0, v1, Lcom/taobao/accs/net/m;->b:Lcom/taobao/accs/net/j;

    iget-object v2, v1, Lcom/taobao/accs/net/m;->a:Lcom/taobao/accs/data/Message;

    const/16 v8, 0x7d0

    invoke-virtual {v0, v2, v8}, Lcom/taobao/accs/net/j;->a(Lcom/taobao/accs/data/Message;I)Z

    move-result v0

    if-nez v0, :cond_d

    :cond_c
    iget-object v0, v1, Lcom/taobao/accs/net/m;->b:Lcom/taobao/accs/net/j;

    .line 274
    iget-object v0, v0, Lcom/taobao/accs/net/j;->e:Lcom/taobao/accs/data/d;

    iget-object v2, v1, Lcom/taobao/accs/net/m;->a:Lcom/taobao/accs/data/Message;

    invoke-virtual {v0, v2, v7}, Lcom/taobao/accs/data/d;->a(Lcom/taobao/accs/data/Message;Lcom/alibaba/sdk/android/error/ErrorCode;)V

    :cond_d
    iget-object v0, v1, Lcom/taobao/accs/net/m;->a:Lcom/taobao/accs/data/Message;

    .line 276
    iget v0, v0, Lcom/taobao/accs/data/Message;->R:I

    if-ne v0, v9, :cond_f

    iget-object v0, v1, Lcom/taobao/accs/net/m;->a:Lcom/taobao/accs/data/Message;

    .line 277
    invoke-virtual {v0}, Lcom/taobao/accs/data/Message;->e()Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;

    move-result-object v0

    if-eqz v0, :cond_f

    const-string v0, "total_accs"

    const-wide/16 v7, 0x0

    const-string v2, "resend"

    .line 278
    invoke-static {v3, v2, v0, v7, v8}, Lcom/taobao/accs/utl/AppMonitorAdapter;->commitCount(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;D)V

    goto :goto_7

    :cond_e
    iget-object v0, v1, Lcom/taobao/accs/net/m;->b:Lcom/taobao/accs/net/j;

    .line 282
    iget-object v0, v0, Lcom/taobao/accs/net/j;->e:Lcom/taobao/accs/data/d;

    iget-object v2, v1, Lcom/taobao/accs/net/m;->a:Lcom/taobao/accs/data/Message;

    invoke-virtual {v0, v2, v7}, Lcom/taobao/accs/data/d;->a(Lcom/taobao/accs/data/Message;Lcom/alibaba/sdk/android/error/ErrorCode;)V

    :cond_f
    :goto_7
    iget-object v0, v1, Lcom/taobao/accs/net/m;->b:Lcom/taobao/accs/net/j;

    .line 285
    invoke-static {v0}, Lcom/taobao/accs/net/j;->a(Lcom/taobao/accs/net/j;)Lcom/alibaba/sdk/android/logger/ILog;

    move-result-object v0

    iget-object v2, v1, Lcom/taobao/accs/net/m;->a:Lcom/taobao/accs/data/Message;

    invoke-virtual {v2}, Lcom/taobao/accs/data/Message;->b()Ljava/lang/String;

    move-result-object v2

    .line 286
    invoke-static {v14}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    filled-new-array {v5, v6, v2, v4, v3}, [Ljava/lang/Object;

    move-result-object v2

    .line 285
    invoke-interface {v0, v2}, Lcom/alibaba/sdk/android/logger/ILog;->i([Ljava/lang/Object;)V

    goto :goto_8

    :catchall_1
    move-exception v0

    :try_start_4
    const-string v7, "send_fail"

    iget-object v8, v1, Lcom/taobao/accs/net/m;->a:Lcom/taobao/accs/data/Message;

    .line 259
    iget-object v8, v8, Lcom/taobao/accs/data/Message;->H:Ljava/lang/String;

    const-string v10, ""

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v12, v1, Lcom/taobao/accs/net/m;->b:Lcom/taobao/accs/net/j;

    iget v12, v12, Lcom/taobao/accs/net/j;->c:I

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v11

    .line 261
    invoke-virtual {v0}, Ljava/lang/Throwable;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    .line 259
    invoke-static {v3, v7, v8, v10, v11}, Lcom/taobao/accs/utl/AppMonitorAdapter;->commitAlarmFail(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    iget-object v3, v1, Lcom/taobao/accs/net/m;->b:Lcom/taobao/accs/net/j;

    .line 262
    invoke-static {v3}, Lcom/taobao/accs/net/j;->a(Lcom/taobao/accs/net/j;)Lcom/alibaba/sdk/android/logger/ILog;

    move-result-object v3

    invoke-interface {v3, v2, v0}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;Ljava/lang/Throwable;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    iget-object v0, v1, Lcom/taobao/accs/net/m;->b:Lcom/taobao/accs/net/j;

    .line 285
    invoke-static {v0}, Lcom/taobao/accs/net/j;->a(Lcom/taobao/accs/net/j;)Lcom/alibaba/sdk/android/logger/ILog;

    move-result-object v0

    iget-object v2, v1, Lcom/taobao/accs/net/m;->a:Lcom/taobao/accs/data/Message;

    invoke-virtual {v2}, Lcom/taobao/accs/data/Message;->b()Ljava/lang/String;

    move-result-object v2

    .line 286
    invoke-static {v9}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    filled-new-array {v5, v6, v2, v4, v3}, [Ljava/lang/Object;

    move-result-object v2

    .line 285
    invoke-interface {v0, v2}, Lcom/alibaba/sdk/android/logger/ILog;->i([Ljava/lang/Object;)V

    goto :goto_8

    :catchall_2
    move-exception v0

    iget-object v2, v1, Lcom/taobao/accs/net/m;->b:Lcom/taobao/accs/net/j;

    invoke-static {v2}, Lcom/taobao/accs/net/j;->a(Lcom/taobao/accs/net/j;)Lcom/alibaba/sdk/android/logger/ILog;

    move-result-object v2

    iget-object v3, v1, Lcom/taobao/accs/net/m;->a:Lcom/taobao/accs/data/Message;

    invoke-virtual {v3}, Lcom/taobao/accs/data/Message;->b()Ljava/lang/String;

    move-result-object v3

    .line 286
    invoke-static {v9}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v7

    filled-new-array {v5, v6, v3, v4, v7}, [Ljava/lang/Object;

    move-result-object v3

    .line 285
    invoke-interface {v2, v3}, Lcom/alibaba/sdk/android/logger/ILog;->i([Ljava/lang/Object;)V

    .line 287
    throw v0

    :cond_10
    :goto_8
    return-void
.end method
