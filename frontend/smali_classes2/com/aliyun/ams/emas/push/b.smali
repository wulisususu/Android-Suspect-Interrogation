.class Lcom/aliyun/ams/emas/push/b;
.super Ljava/lang/Object;
.source "Taobao"


# direct methods
.method constructor <init>()V
    .locals 0

    .line 34
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static a(Landroid/content/Context;Landroid/content/Intent;Lcom/aliyun/ams/emas/push/IAgooPushCallback;)V
    .locals 9

    const-string v0, "notification opened "

    :try_start_0
    const-string v1, "messageId"

    .line 249
    invoke-virtual {p1, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "title"

    .line 250
    invoke-virtual {p1, v2}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    const-string v2, "summary"

    .line 251
    invoke-virtual {p1, v2}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    const-string v2, "extraMap"

    .line 252
    invoke-virtual {p1, v2}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    const-string v2, "group"

    .line 253
    invoke-virtual {p1, v2}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const-string v3, "notificationOpenType"

    const/4 v4, 0x1

    .line 254
    invoke-virtual {p1, v3, v4}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v8

    .line 255
    sget-object p1, Lcom/aliyun/ams/emas/push/h;->importantLogger:Lcom/alibaba/sdk/android/logger/ILog;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-interface {p1, v0}, Lcom/alibaba/sdk/android/logger/ILog;->d(Ljava/lang/String;)V

    .line 257
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result p1

    if-nez p1, :cond_0

    .line 258
    invoke-static {}, Lcom/aliyun/ams/emas/push/a/a;->a()Lcom/aliyun/ams/emas/push/a/a;

    move-result-object p1

    invoke-virtual {p1, v2}, Lcom/aliyun/ams/emas/push/a/a;->a(Ljava/lang/String;)V

    :cond_0
    move-object v3, p2

    move-object v4, p0

    .line 261
    invoke-interface/range {v3 .. v8}, Lcom/aliyun/ams/emas/push/IAgooPushCallback;->onNotificationOpened(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception p0

    const/4 p1, 0x0

    new-array p1, p1, [Ljava/lang/Object;

    const-string p2, "AgooPushHandler"

    const-string v0, "Handle notification open action failed."

    .line 263
    invoke-static {p2, v0, p0, p1}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :goto_0
    return-void
.end method

.method public static a(Landroid/content/Context;Landroid/content/Intent;Lcom/aliyun/ams/emas/push/IAgooPushConfig;Lcom/aliyun/ams/emas/push/IAgooPushCallback;)V
    .locals 16

    move-object/from16 v0, p1

    const-string v1, "message_source"

    const-string v2, "extData"

    const-string v3, "task_id"

    const-string v4, "AgooPushHandler"

    const-string v5, "handle message, messageId:"

    const/4 v6, 0x0

    :try_start_0
    const-string v7, "id"

    .line 43
    invoke-virtual {v0, v7}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    .line 44
    invoke-static {v11}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v7

    if-eqz v7, :cond_0

    const-string v0, "handle message Null messageId!"

    new-array v1, v6, [Ljava/lang/Object;

    .line 45
    invoke-static {v4, v0, v1}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void

    :cond_0
    const-string v7, "body"

    .line 49
    invoke-virtual {v0, v7}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 50
    invoke-virtual {v0, v3}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    .line 51
    invoke-virtual {v0, v2}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    .line 52
    invoke-virtual {v0, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    .line 54
    invoke-static {v7}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_1

    const-string v0, "handle message json body is Empty!"

    new-array v1, v6, [Ljava/lang/Object;

    .line 55
    invoke-static {v4, v0, v1}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    return-void

    .line 61
    :cond_1
    :try_start_1
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, v7}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 62
    invoke-static {v0}, Lcom/taobao/accs/utl/JsonUtility;->toMap(Lorg/json/JSONObject;)Ljava/util/Map;

    move-result-object v0
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    :goto_0
    move-object v12, v0

    goto :goto_1

    :catch_0
    move-exception v0

    :try_start_2
    const-string v12, "Parse json error:"

    new-array v13, v6, [Ljava/lang/Object;

    .line 64
    invoke-static {v4, v12, v0, v13}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    const/4 v0, 0x0

    goto :goto_0

    :goto_1
    :try_start_3
    const-string v0, "type"

    .line 69
    invoke-interface {v12, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v13
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 75
    :try_start_4
    sget-object v0, Lcom/aliyun/ams/emas/push/h;->importantLogger:Lcom/alibaba/sdk/android/logger/ILog;

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v14, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v14, ", type:"

    invoke-virtual {v5, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v13}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v14, ", msg receive:"

    invoke-virtual {v5, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-interface {v0, v5}, Lcom/alibaba/sdk/android/logger/ILog;->d(Ljava/lang/String;)V

    .line 80
    invoke-interface {v12}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_2
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/util/Map$Entry;

    .line 81
    sget-object v7, Lcom/aliyun/ams/emas/push/h;->importantLogger:Lcom/alibaba/sdk/android/logger/ILog;

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    invoke-interface {v5}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v15

    check-cast v15, Ljava/lang/String;

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    const-string v15, " --> "

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-interface {v5}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    invoke-virtual {v14, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-interface {v7, v5}, Lcom/alibaba/sdk/android/logger/ILog;->d(Ljava/lang/String;)V

    goto :goto_2

    :cond_2
    const-string v0, "msg_id"

    .line 84
    invoke-interface {v12, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 87
    invoke-interface {v12, v3, v8}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 88
    invoke-interface {v12, v2, v9}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 89
    invoke-interface {v12, v1, v10}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v1, "_ALIYUN_NOTIFICATION_MSG_ID_"

    .line 91
    invoke-interface {v12, v1, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 93
    invoke-static {}, Lcom/aliyun/ams/emas/push/h;->b()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 94
    sget-object v0, Lcom/aliyun/ams/emas/push/h;->importantLogger:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v1, "Push received in DoNotDisturb time window, ignored."

    invoke-interface {v0, v1}, Lcom/alibaba/sdk/android/logger/ILog;->d(Ljava/lang/String;)V

    return-void

    :cond_3
    move-object/from16 v8, p0

    move-object/from16 v9, p2

    move-object/from16 v10, p3

    .line 99
    invoke-static/range {v8 .. v13}, Lcom/aliyun/ams/emas/push/b;->a(Landroid/content/Context;Lcom/aliyun/ams/emas/push/IAgooPushConfig;Lcom/aliyun/ams/emas/push/IAgooPushCallback;Ljava/lang/String;Ljava/util/Map;I)V

    goto :goto_3

    :catchall_0
    move-exception v0

    const-string v1, "Wrong message Type Define!"

    new-array v2, v6, [Ljava/lang/Object;

    .line 71
    invoke-static {v4, v1, v0, v2}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    return-void

    :catchall_1
    move-exception v0

    const-string v1, "onHandleCallException"

    new-array v2, v6, [Ljava/lang/Object;

    .line 102
    invoke-static {v4, v1, v0, v2}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :goto_3
    return-void
.end method

.method private static a(Landroid/content/Context;Lcom/aliyun/ams/emas/push/IAgooPushConfig;Lcom/aliyun/ams/emas/push/IAgooPushCallback;Ljava/lang/String;Ljava/util/Map;I)V
    .locals 13
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Lcom/aliyun/ams/emas/push/IAgooPushConfig;",
            "Lcom/aliyun/ams/emas/push/IAgooPushCallback;",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;I)V"
        }
    .end annotation

    move-object v7, p0

    move-object v0, p1

    move-object/from16 v1, p3

    move-object/from16 v8, p4

    move/from16 v2, p5

    const-string v3, "messageId="

    const-string v4, "Notify title is null or server push data Error appId =  "

    .line 163
    new-instance v5, Lcom/aliyun/ams/emas/push/notification/b;

    invoke-direct {v5}, Lcom/aliyun/ams/emas/push/notification/b;-><init>()V

    const/4 v6, 0x1

    const/4 v9, 0x0

    const-string v10, "AgooPushHandler"

    if-eq v2, v6, :cond_1

    const/4 v0, 0x2

    if-eq v2, v0, :cond_0

    const-string v0, "Wrong message Type Define!"

    new-array v1, v9, [Ljava/lang/Object;

    .line 239
    invoke-static {v10, v0, v1}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    goto/16 :goto_1

    .line 219
    :cond_0
    invoke-static {p0}, Lorg/android/agoo/common/Config;->b(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v4

    .line 221
    :try_start_0
    invoke-virtual {v5, v8, v4, v1}, Lcom/aliyun/ams/emas/push/notification/b;->a(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)Lcom/aliyun/ams/emas/push/notification/CPushMessage;

    move-result-object v1

    if-eqz v1, :cond_5

    .line 224
    invoke-virtual {v1}, Lcom/aliyun/ams/emas/push/notification/CPushMessage;->getMessageId()Ljava/lang/String;

    move-result-object v4

    invoke-static {p0, v4, v2}, Lcom/aliyun/ams/emas/push/h;->a(Landroid/content/Context;Ljava/lang/String;I)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 226
    :try_start_1
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Lcom/aliyun/ams/emas/push/notification/CPushMessage;->getMessageId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ";appId="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 227
    invoke-virtual {v1}, Lcom/aliyun/ams/emas/push/notification/CPushMessage;->getAppId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ";messageType=msg"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    new-array v0, v0, [Ljava/lang/Object;

    const/4 v3, 0x0

    aput-object v3, v0, v9

    .line 228
    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v0, v6

    .line 226
    invoke-static {v10, v2, v0}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v0

    :try_start_2
    const-string v2, "ut log error"

    new-array v3, v9, [Ljava/lang/Object;

    .line 230
    invoke-static {v10, v2, v0, v3}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :goto_0
    move-object v6, p2

    .line 232
    invoke-interface {p2, p0, v1}, Lcom/aliyun/ams/emas/push/IAgooPushCallback;->onMessageArrived(Landroid/content/Context;Lcom/aliyun/ams/emas/push/notification/CPushMessage;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    goto/16 :goto_1

    :catchall_1
    move-exception v0

    const-string v1, "Custom message parse error:"

    new-array v2, v9, [Ljava/lang/Object;

    .line 235
    invoke-static {v10, v1, v0, v2}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    goto/16 :goto_1

    :cond_1
    move-object v6, p2

    .line 168
    :try_start_3
    invoke-static {p0}, Lorg/android/agoo/common/Config;->b(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v3

    .line 169
    invoke-virtual {v5, v8, v3, v1}, Lcom/aliyun/ams/emas/push/notification/b;->b(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)Lcom/aliyun/ams/emas/push/notification/a;

    move-result-object v11

    if-eqz v11, :cond_4

    .line 172
    invoke-virtual {v11}, Lcom/aliyun/ams/emas/push/notification/a;->f()Ljava/lang/String;

    move-result-object v1

    invoke-static {p0, v1, v2}, Lcom/aliyun/ams/emas/push/h;->a(Landroid/content/Context;Ljava/lang/String;I)V

    .line 173
    invoke-interface {p1, p0, v8}, Lcom/aliyun/ams/emas/push/IAgooPushConfig;->showNotificationNow(Landroid/content/Context;Ljava/util/Map;)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 175
    invoke-virtual {v11}, Lcom/aliyun/ams/emas/push/notification/a;->o()Ljava/lang/String;

    move-result-object v1

    .line 176
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_2

    .line 177
    invoke-static {}, Lcom/aliyun/ams/emas/push/a/a;->a()Lcom/aliyun/ams/emas/push/a/a;

    move-result-object v2

    invoke-virtual {v2, v1, v11}, Lcom/aliyun/ams/emas/push/a/a;->a(Ljava/lang/String;Lcom/aliyun/ams/emas/push/notification/a;)V

    .line 180
    :cond_2
    new-instance v12, Lcom/aliyun/ams/emas/push/e;

    move-object v1, v12

    move-object/from16 v2, p4

    move-object v3, v11

    move-object v4, v5

    move-object v5, p0

    move-object v6, p2

    invoke-direct/range {v1 .. v6}, Lcom/aliyun/ams/emas/push/e;-><init>(Ljava/util/Map;Lcom/aliyun/ams/emas/push/notification/a;Lcom/aliyun/ams/emas/push/notification/b;Landroid/content/Context;Lcom/aliyun/ams/emas/push/IAgooPushCallback;)V

    invoke-static {p0, p1, v8, v12}, Lcom/aliyun/ams/emas/push/b;->a(Landroid/content/Context;Lcom/aliyun/ams/emas/push/IAgooPushConfig;Ljava/util/Map;Lcom/aliyun/ams/emas/push/g;)V

    goto :goto_1

    .line 202
    :cond_3
    sget-object v0, Lcom/aliyun/ams/emas/push/h;->importantLogger:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v1, "do not build notification as user request"

    invoke-interface {v0, v1}, Lcom/alibaba/sdk/android/logger/ILog;->i(Ljava/lang/String;)V

    .line 205
    invoke-virtual {v11}, Lcom/aliyun/ams/emas/push/notification/a;->b()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v11}, Lcom/aliyun/ams/emas/push/notification/a;->c()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v11}, Lcom/aliyun/ams/emas/push/notification/a;->e()Ljava/util/Map;

    move-result-object v5

    .line 206
    invoke-virtual {v11}, Lcom/aliyun/ams/emas/push/notification/a;->a()I

    move-result v0

    invoke-virtual {v11}, Lcom/aliyun/ams/emas/push/notification/a;->h()Ljava/lang/String;

    move-result-object v8

    .line 207
    invoke-virtual {v11}, Lcom/aliyun/ams/emas/push/notification/a;->d()Ljava/lang/String;

    move-result-object v11

    move-object v1, p2

    move-object v2, p0

    move v6, v0

    move-object v7, v8

    move-object v8, v11

    .line 204
    invoke-interface/range {v1 .. v8}, Lcom/aliyun/ams/emas/push/IAgooPushCallback;->onNotificationReceivedWithoutShow(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;ILjava/lang/String;Ljava/lang/String;)V

    goto :goto_1

    .line 210
    :cond_4
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-array v1, v9, [Ljava/lang/Object;

    invoke-static {v10, v0, v1}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    goto :goto_1

    :catchall_2
    move-exception v0

    const-string v1, "Notify message error:"

    new-array v2, v9, [Ljava/lang/Object;

    .line 214
    invoke-static {v10, v1, v0, v2}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :cond_5
    :goto_1
    return-void
.end method

.method private static a(Landroid/content/Context;Lcom/aliyun/ams/emas/push/IAgooPushConfig;Ljava/util/Map;Lcom/aliyun/ams/emas/push/g;)V
    .locals 11
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Lcom/aliyun/ams/emas/push/IAgooPushConfig;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/aliyun/ams/emas/push/g;",
            ")V"
        }
    .end annotation

    const-string v0, "image"

    .line 110
    invoke-interface {p2, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    const-string v1, "big_picture"

    .line 112
    invoke-interface {p2, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    const-string v2, "tid"

    .line 113
    invoke-interface {p2, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    move-object v7, v2

    check-cast v7, Ljava/lang/String;

    .line 114
    invoke-interface {p1, p2}, Lcom/aliyun/ams/emas/push/IAgooPushConfig;->checkNotificationShowInInnerGroup(Ljava/util/Map;)Z

    move-result v8

    .line 115
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    const/4 v2, 0x0

    if-eqz v0, :cond_2

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 117
    invoke-interface {p1, p0, p2}, Lcom/aliyun/ams/emas/push/IAgooPushConfig;->customNotificationUI(Landroid/content/Context;Ljava/util/Map;)Landroid/app/Notification;

    move-result-object v0

    .line 119
    invoke-static {v7}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    if-eqz v8, :cond_1

    .line 120
    :cond_0
    invoke-interface {p1, p0, p2}, Lcom/aliyun/ams/emas/push/IAgooPushConfig;->customSummaryNotification(Landroid/content/Context;Ljava/util/Map;)Landroid/app/Notification;

    move-result-object v2

    .line 122
    :cond_1
    invoke-interface {p3, v0, v2}, Lcom/aliyun/ams/emas/push/g;->a(Landroid/app/Notification;Landroid/app/Notification;)V

    goto :goto_1

    .line 125
    :cond_2
    invoke-static {}, Landroid/os/Looper;->myLooper()Landroid/os/Looper;

    move-result-object v0

    if-eqz v0, :cond_3

    .line 127
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->myLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    move-object v9, v0

    goto :goto_0

    :cond_3
    move-object v9, v2

    .line 131
    :goto_0
    new-instance v0, Lcom/aliyun/ams/emas/push/c;

    move-object v3, v0

    move-object v4, p1

    move-object v5, p0

    move-object v6, p2

    move-object v10, p3

    invoke-direct/range {v3 .. v10}, Lcom/aliyun/ams/emas/push/c;-><init>(Lcom/aliyun/ams/emas/push/IAgooPushConfig;Landroid/content/Context;Ljava/util/Map;Ljava/lang/String;ZLandroid/os/Handler;Lcom/aliyun/ams/emas/push/g;)V

    invoke-static {v0}, Lcom/taobao/accs/common/ThreadPoolExecutorFactory;->execute(Ljava/lang/Runnable;)V

    :goto_1
    return-void
.end method

.method public static b(Landroid/content/Context;Landroid/content/Intent;Lcom/aliyun/ams/emas/push/IAgooPushCallback;)V
    .locals 9

    const-string v0, "notification deleted "

    :try_start_0
    const-string v1, "messageId"

    .line 273
    invoke-virtual {p1, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    const-string v1, "title"

    .line 274
    invoke-virtual {p1, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    const-string v1, "summary"

    .line 275
    invoke-virtual {p1, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    const-string v1, "extraMap"

    .line 276
    invoke-virtual {p1, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    const-string v1, "notificationOpenType"

    const/4 v2, 0x1

    .line 277
    invoke-virtual {p1, v1, v2}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v7

    const-string v1, "group"

    .line 278
    invoke-virtual {p1, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    .line 279
    sget-object v1, Lcom/aliyun/ams/emas/push/h;->importantLogger:Lcom/alibaba/sdk/android/logger/ILog;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-interface {v1, v0}, Lcom/alibaba/sdk/android/logger/ILog;->d(Ljava/lang/String;)V

    .line 281
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 282
    invoke-static {}, Lcom/aliyun/ams/emas/push/a/a;->a()Lcom/aliyun/ams/emas/push/a/a;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/aliyun/ams/emas/push/a/a;->a(Ljava/lang/String;)V

    :cond_0
    move-object v2, p2

    move-object v3, p0

    .line 284
    invoke-interface/range {v2 .. v8}, Lcom/aliyun/ams/emas/push/IAgooPushCallback;->onNotificationRemoved(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception p0

    const/4 p1, 0x0

    new-array p1, p1, [Ljava/lang/Object;

    const-string p2, "AgooPushHandler"

    const-string v0, "Handle notification delete action failed."

    .line 287
    invoke-static {p2, v0, p0, p1}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :goto_0
    return-void
.end method
