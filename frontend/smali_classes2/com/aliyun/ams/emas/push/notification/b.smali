.class public Lcom/aliyun/ams/emas/push/notification/b;
.super Ljava/lang/Object;
.source "Taobao"


# static fields
.field public static final APP_ID:Ljava/lang/String; = "appId"

.field public static final EXTRA_MAP:Ljava/lang/String; = "extraMap"

.field public static final EXT_DATA:Ljava/lang/String; = "extData"

.field public static final MSG_ID:Ljava/lang/String; = "msgId"

.field public static final NOTIFICATION_GROUP:Ljava/lang/String; = "group"

.field public static final NOTIFICATION_ID:Ljava/lang/String; = "notificationId"

.field public static final NOTIFICATION_OPEN_TYPE:Ljava/lang/String; = "notificationOpenType"

.field public static final SUMMARY:Ljava/lang/String; = "summary"

.field public static final TAG:Ljava/lang/String; = "MPS:MessageNotification"

.field public static final TASK_ID:Ljava/lang/String; = "task_id"

.field public static final TITLE:Ljava/lang/String; = "title"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 36
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private a(Landroid/content/Context;Lcom/aliyun/ams/emas/push/notification/a;I)Landroid/app/PendingIntent;
    .locals 4

    .line 289
    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0}, Landroid/content/Intent;-><init>()V

    .line 290
    invoke-virtual {p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    const-class v2, Lcom/aliyun/ams/emas/push/MsgService;

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->setClassName(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 291
    sget-object v1, Lcom/aliyun/ams/emas/push/h;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    const-string v1, "action_type"

    const-string v2, "notification_delete"

    .line 292
    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v1, "task_id"

    .line 293
    invoke-virtual {p2}, Lcom/aliyun/ams/emas/push/notification/a;->k()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v1, "extData"

    .line 294
    invoke-virtual {p2}, Lcom/aliyun/ams/emas/push/notification/a;->l()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v1, "msgId"

    .line 296
    invoke-virtual {p2}, Lcom/aliyun/ams/emas/push/notification/a;->f()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v1, "title"

    .line 297
    invoke-virtual {p2}, Lcom/aliyun/ams/emas/push/notification/a;->b()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v1, "summary"

    .line 298
    invoke-virtual {p2}, Lcom/aliyun/ams/emas/push/notification/a;->c()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v1, "notificationOpenType"

    .line 299
    invoke-virtual {p2}, Lcom/aliyun/ams/emas/push/notification/a;->a()I

    move-result v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const-string v1, "notificationId"

    .line 300
    invoke-virtual {p2}, Lcom/aliyun/ams/emas/push/notification/a;->i()I

    move-result v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const-string v1, "group"

    .line 301
    invoke-virtual {p2}, Lcom/aliyun/ams/emas/push/notification/a;->o()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 302
    invoke-virtual {p2}, Lcom/aliyun/ams/emas/push/notification/a;->e()Ljava/util/Map;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 303
    new-instance v1, Lorg/json/JSONObject;

    invoke-virtual {p2}, Lcom/aliyun/ams/emas/push/notification/a;->e()Ljava/util/Map;

    move-result-object v2

    invoke-direct {v1, v2}, Lorg/json/JSONObject;-><init>(Ljava/util/Map;)V

    const-string v2, "extraMap"

    .line 304
    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v2, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 306
    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "delete content messageId:"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p2}, Lcom/aliyun/ams/emas/push/notification/a;->f()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    const-string v3, "MPS:MessageNotification"

    invoke-static {v3, v1, v2}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const-string v1, "appId"

    .line 308
    invoke-virtual {p2}, Lcom/aliyun/ams/emas/push/notification/a;->g()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v0, v1, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const/high16 p2, 0xc000000

    .line 311
    invoke-static {p1, p3, v0, p2}, Landroid/app/PendingIntent;->getService(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object p1

    return-object p1
.end method

.method private a(Landroid/content/Context;Lcom/aliyun/ams/emas/push/notification/a;Landroid/content/Intent;I)Landroid/app/PendingIntent;
    .locals 7

    .line 325
    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0}, Landroid/content/Intent;-><init>()V

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1e

    if-gt v1, v2, :cond_1

    .line 326
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    move-result-object v1

    iget v1, v1, Landroid/content/pm/ApplicationInfo;->targetSdkVersion:I

    if-le v1, v2, :cond_0

    goto :goto_0

    .line 330
    :cond_0
    invoke-virtual {p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    const-class v3, Lcom/aliyun/ams/emas/push/MsgService;

    invoke-virtual {v3}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v1, v3}, Landroid/content/Intent;->setClassName(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    goto :goto_1

    .line 327
    :cond_1
    :goto_0
    invoke-virtual {p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    const-class v3, Lcom/aliyun/ams/emas/push/NotificationActivity;

    .line 328
    invoke-virtual {v3}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v3

    .line 327
    invoke-virtual {v0, v1, v3}, Landroid/content/Intent;->setClassName(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 332
    :goto_1
    sget-object v1, Lcom/aliyun/ams/emas/push/h;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    const-string v1, "action_type"

    const-string v3, "notification_open"

    .line 333
    invoke-virtual {v0, v1, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v1, "task_id"

    .line 334
    invoke-virtual {p2}, Lcom/aliyun/ams/emas/push/notification/a;->k()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v1, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v1, "extData"

    .line 335
    invoke-virtual {p2}, Lcom/aliyun/ams/emas/push/notification/a;->l()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v1, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 336
    invoke-virtual {p2}, Lcom/aliyun/ams/emas/push/notification/a;->o()Ljava/lang/String;

    move-result-object v1

    .line 337
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    const-string v4, "group"

    if-nez v3, :cond_2

    .line 338
    invoke-virtual {v0, v4, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    :cond_2
    const-string v3, "title"

    .line 341
    invoke-virtual {p2}, Lcom/aliyun/ams/emas/push/notification/a;->b()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p3, v3, v5}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v3, "summary"

    .line 342
    invoke-virtual {p2}, Lcom/aliyun/ams/emas/push/notification/a;->c()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p3, v3, v5}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 343
    invoke-virtual {p2}, Lcom/aliyun/ams/emas/push/notification/a;->f()Ljava/lang/String;

    move-result-object v3

    const-string v5, "msgId"

    invoke-virtual {p3, v5, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v3, "appId"

    .line 344
    invoke-virtual {p2}, Lcom/aliyun/ams/emas/push/notification/a;->g()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {p3, v3, v6}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v3, "notificationOpenType"

    .line 345
    invoke-virtual {p2}, Lcom/aliyun/ams/emas/push/notification/a;->a()I

    move-result v6

    invoke-virtual {p3, v3, v6}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const-string v3, "notificationId"

    .line 346
    invoke-virtual {p2}, Lcom/aliyun/ams/emas/push/notification/a;->i()I

    move-result v6

    invoke-virtual {p3, v3, v6}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    .line 348
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_3

    .line 349
    invoke-virtual {p3, v4, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 352
    :cond_3
    invoke-virtual {p2}, Lcom/aliyun/ams/emas/push/notification/a;->f()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v5, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 354
    invoke-virtual {p2}, Lcom/aliyun/ams/emas/push/notification/a;->e()Ljava/util/Map;

    move-result-object v1

    if-eqz v1, :cond_4

    .line 355
    new-instance v1, Lorg/json/JSONObject;

    invoke-virtual {p2}, Lcom/aliyun/ams/emas/push/notification/a;->e()Ljava/util/Map;

    move-result-object v3

    invoke-direct {v1, v3}, Lorg/json/JSONObject;-><init>(Ljava/util/Map;)V

    const-string v3, "extraMap"

    .line 356
    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p3, v3, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 359
    :cond_4
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v3, "build content messageId:"

    invoke-direct {v1, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p2}, Lcom/aliyun/ams/emas/push/notification/a;->f()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    const-string v3, "MPS:MessageNotification"

    invoke-static {v3, p2, v1}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const-string p2, "realIntent"

    .line 361
    invoke-virtual {v0, p2, p3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    sget p2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/high16 p3, 0xc000000

    if-gt p2, v2, :cond_6

    .line 363
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    move-result-object p2

    iget p2, p2, Landroid/content/pm/ApplicationInfo;->targetSdkVersion:I

    if-le p2, v2, :cond_5

    goto :goto_2

    .line 368
    :cond_5
    invoke-static {p1, p4, v0, p3}, Landroid/app/PendingIntent;->getService(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object p1

    return-object p1

    .line 364
    :cond_6
    :goto_2
    invoke-static {p1, p4, v0, p3}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object p1

    return-object p1
.end method


# virtual methods
.method public a(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)Lcom/aliyun/ams/emas/push/notification/CPushMessage;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ")",
            "Lcom/aliyun/ams/emas/push/notification/CPushMessage;"
        }
    .end annotation

    const-string v0, "title"

    .line 60
    invoke-interface {p1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    const-string v1, "content"

    .line 61
    invoke-interface {p1, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    const-string v2, "extData"

    .line 62
    invoke-interface {p1, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 63
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_1

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_0

    goto :goto_0

    .line 67
    :cond_0
    new-instance p1, Lcom/aliyun/ams/emas/push/notification/CPushMessage;

    invoke-direct {p1}, Lcom/aliyun/ams/emas/push/notification/CPushMessage;-><init>()V

    .line 68
    invoke-virtual {p1, p3}, Lcom/aliyun/ams/emas/push/notification/CPushMessage;->setMessageId(Ljava/lang/String;)V

    .line 69
    invoke-virtual {p1, p2}, Lcom/aliyun/ams/emas/push/notification/CPushMessage;->setAppId(Ljava/lang/String;)V

    .line 70
    invoke-virtual {p1, v0}, Lcom/aliyun/ams/emas/push/notification/CPushMessage;->setTitle(Ljava/lang/String;)V

    .line 71
    invoke-virtual {p1, v1}, Lcom/aliyun/ams/emas/push/notification/CPushMessage;->setContent(Ljava/lang/String;)V

    .line 72
    invoke-virtual {p1, v2}, Lcom/aliyun/ams/emas/push/notification/CPushMessage;->setTraceInfo(Ljava/lang/String;)V

    return-object p1

    .line 64
    :cond_1
    :goto_0
    new-instance p2, Ljava/lang/StringBuilder;

    const-string p3, "Message title or content is empty:"

    invoke-direct {p2, p3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const/4 p2, 0x0

    new-array p2, p2, [Ljava/lang/Object;

    const-string p3, "MPS:MessageNotification"

    invoke-static {p3, p1, p2}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const/4 p1, 0x0

    return-object p1
.end method

.method public a(Landroid/content/Context;Landroid/app/Notification;Landroid/app/Notification;Lcom/aliyun/ams/emas/push/notification/a;)V
    .locals 16

    move-object/from16 v1, p0

    move-object/from16 v2, p1

    move-object/from16 v3, p3

    move-object/from16 v4, p4

    const-string v5, "MPS:MessageNotification"

    const-string v6, "messageId="

    const-string v7, "open type:"

    :try_start_0
    const-string v0, "notification"

    .line 177
    invoke-virtual {v2, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    move-object v8, v0

    check-cast v8, Landroid/app/NotificationManager;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_3

    const-string v0, ""

    if-nez p2, :cond_0

    .line 180
    :try_start_1
    new-instance v9, Lcom/aliyun/ams/emas/push/notification/c;

    invoke-direct {v9}, Lcom/aliyun/ams/emas/push/notification/c;-><init>()V

    .line 182
    invoke-virtual/range {p4 .. p4}, Lcom/aliyun/ams/emas/push/notification/a;->b()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Lcom/aliyun/ams/emas/push/notification/e;->a(Ljava/lang/String;)V

    .line 183
    invoke-virtual/range {p4 .. p4}, Lcom/aliyun/ams/emas/push/notification/a;->c()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Lcom/aliyun/ams/emas/push/notification/e;->b(Ljava/lang/String;)V

    .line 184
    invoke-virtual/range {p4 .. p4}, Lcom/aliyun/ams/emas/push/notification/a;->j()I

    move-result v10

    invoke-virtual {v9, v10}, Lcom/aliyun/ams/emas/push/notification/e;->a(I)V

    .line 185
    invoke-virtual/range {p4 .. p4}, Lcom/aliyun/ams/emas/push/notification/a;->m()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Lcom/aliyun/ams/emas/push/notification/e;->c(Ljava/lang/String;)V

    .line 186
    invoke-virtual/range {p4 .. p4}, Lcom/aliyun/ams/emas/push/notification/a;->o()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Lcom/aliyun/ams/emas/push/notification/e;->d(Ljava/lang/String;)V

    .line 188
    invoke-virtual {v9, v2}, Lcom/aliyun/ams/emas/push/notification/e;->a(Landroid/content/Context;)Landroid/app/Notification;

    move-result-object v9

    if-nez v9, :cond_1

    .line 192
    new-instance v9, Landroid/app/Notification;

    .line 193
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v10

    const v12, 0x1080077

    invoke-direct {v9, v12, v0, v10, v11}, Landroid/app/Notification;-><init>(ILjava/lang/CharSequence;J)V

    goto :goto_0

    :cond_0
    move-object/from16 v9, p2

    .line 197
    :cond_1
    :goto_0
    new-instance v10, Landroid/content/Intent;

    invoke-direct {v10}, Landroid/content/Intent;-><init>()V

    const-string v11, "appId"

    .line 198
    invoke-virtual/range {p4 .. p4}, Lcom/aliyun/ams/emas/push/notification/a;->g()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v10, v11, v12}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v11, "msgId"

    .line 199
    invoke-virtual/range {p4 .. p4}, Lcom/aliyun/ams/emas/push/notification/a;->f()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v10, v11, v12}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v11, "task_id"

    .line 200
    invoke-virtual/range {p4 .. p4}, Lcom/aliyun/ams/emas/push/notification/a;->k()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v10, v11, v12}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v11, "extData"

    .line 201
    invoke-virtual/range {p4 .. p4}, Lcom/aliyun/ams/emas/push/notification/a;->l()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v10, v11, v12}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v11, "message_source"

    .line 202
    invoke-virtual/range {p4 .. p4}, Lcom/aliyun/ams/emas/push/notification/a;->n()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v10, v11, v12}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const/high16 v11, 0x10200000

    .line 203
    invoke-virtual {v10, v11}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_3

    const/4 v11, 0x2

    const/4 v12, 0x1

    const/4 v13, 0x0

    .line 208
    :try_start_2
    invoke-virtual/range {p4 .. p4}, Lcom/aliyun/ams/emas/push/notification/a;->a()I

    move-result v14

    if-eq v14, v12, :cond_5

    if-eq v14, v11, :cond_4

    const/4 v15, 0x3

    if-eq v14, v15, :cond_3

    const/4 v15, 0x4

    if-eq v14, v15, :cond_2

    goto :goto_2

    :cond_2
    const-string v0, "no action"

    goto :goto_2

    :cond_3
    const-string v0, "url"

    const-string v14, "android.intent.action.VIEW"

    .line 226
    invoke-virtual {v10, v14}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    .line 227
    invoke-virtual/range {p4 .. p4}, Lcom/aliyun/ams/emas/push/notification/a;->d()Ljava/lang/String;

    move-result-object v14

    invoke-static {v14}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v14

    invoke-virtual {v10, v14}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;

    goto :goto_2

    :cond_4
    const-string v14, "activity"
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 213
    :try_start_3
    invoke-virtual/range {p4 .. p4}, Lcom/aliyun/ams/emas/push/notification/a;->h()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    .line 214
    invoke-virtual {v10, v2, v0}, Landroid/content/Intent;->setClass(Landroid/content/Context;Ljava/lang/Class;)Landroid/content/Intent;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_1

    :catchall_0
    move-exception v0

    :try_start_4
    const-string v15, "can\'t find certain activity class: "

    new-array v12, v13, [Ljava/lang/Object;

    .line 216
    invoke-static {v5, v15, v0, v12}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :goto_1
    move-object v0, v14

    goto :goto_2

    :cond_5
    const-string v0, "app"

    .line 221
    invoke-virtual/range {p1 .. p1}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v12

    .line 222
    invoke-virtual/range {p1 .. p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v14

    .line 221
    invoke-virtual {v12, v14}, Landroid/content/pm/PackageManager;->getLaunchIntentForPackage(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v10

    .line 233
    :goto_2
    invoke-virtual {v7, v0}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    new-array v7, v13, [Ljava/lang/Object;

    invoke-static {v5, v0, v7}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    goto :goto_3

    :catchall_1
    move-exception v0

    :try_start_5
    const-string v7, "openType exception"

    new-array v12, v13, [Ljava/lang/Object;

    .line 236
    invoke-static {v5, v7, v0, v12}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    .line 241
    :goto_3
    invoke-static {}, Lcom/aliyun/ams/emas/push/h;->d()I

    move-result v0

    .line 240
    invoke-direct {v1, v2, v4, v10, v0}, Lcom/aliyun/ams/emas/push/notification/b;->a(Landroid/content/Context;Lcom/aliyun/ams/emas/push/notification/a;Landroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v0

    iput-object v0, v9, Landroid/app/Notification;->contentIntent:Landroid/app/PendingIntent;

    .line 245
    invoke-static {}, Lcom/aliyun/ams/emas/push/h;->d()I

    move-result v0

    .line 244
    invoke-direct {v1, v2, v4, v0}, Lcom/aliyun/ams/emas/push/notification/b;->a(Landroid/content/Context;Lcom/aliyun/ams/emas/push/notification/a;I)Landroid/app/PendingIntent;

    move-result-object v0

    iput-object v0, v9, Landroid/app/Notification;->deleteIntent:Landroid/app/PendingIntent;
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_3

    .line 248
    :try_start_6
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual/range {p4 .. p4}, Lcom/aliyun/ams/emas/push/notification/a;->f()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, ";appId="

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 249
    invoke-virtual/range {p4 .. p4}, Lcom/aliyun/ams/emas/push/notification/a;->g()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, ";messageType=notify"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-array v2, v11, [Ljava/lang/Object;

    const/4 v6, 0x0

    aput-object v6, v2, v13

    const/4 v6, 0x1

    .line 250
    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    aput-object v7, v2, v6

    .line 248
    invoke-static {v5, v0, v2}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_2

    goto :goto_4

    :catchall_2
    move-exception v0

    :try_start_7
    const-string v2, "ut log error"

    new-array v6, v13, [Ljava/lang/Object;

    .line 252
    invoke-static {v5, v2, v0, v6}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    .line 255
    :goto_4
    invoke-static {}, Lcom/aliyun/ams/emas/push/a/a;->a()Lcom/aliyun/ams/emas/push/a/a;

    move-result-object v0

    invoke-virtual/range {p4 .. p4}, Lcom/aliyun/ams/emas/push/notification/a;->i()I

    move-result v2

    invoke-virtual {v0, v2}, Lcom/aliyun/ams/emas/push/a/a;->a(I)V

    .line 257
    invoke-virtual/range {p4 .. p4}, Lcom/aliyun/ams/emas/push/notification/a;->i()I

    move-result v0

    invoke-virtual {v8, v0, v9}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V

    .line 258
    sget-object v0, Lcom/aliyun/ams/emas/push/h;->importantLogger:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v2, "push notify notification"

    invoke-interface {v0, v2}, Lcom/alibaba/sdk/android/logger/ILog;->d(Ljava/lang/String;)V

    .line 260
    invoke-virtual/range {p4 .. p4}, Lcom/aliyun/ams/emas/push/notification/a;->o()Ljava/lang/String;

    move-result-object v0

    .line 261
    invoke-virtual/range {p4 .. p4}, Lcom/aliyun/ams/emas/push/notification/a;->p()Ljava/lang/String;

    move-result-object v2

    if-eqz v3, :cond_7

    .line 264
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_6

    .line 266
    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v0

    .line 267
    invoke-virtual {v8, v0, v3}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V

    goto :goto_5

    .line 269
    :cond_6
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_7

    .line 271
    invoke-virtual {v8, v13, v3}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_3

    goto :goto_5

    :catchall_3
    move-exception v0

    .line 277
    sget-object v2, Lcom/aliyun/ams/emas/push/h;->importantLogger:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v3, "onNotification"

    invoke-interface {v2, v3, v0}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 278
    invoke-static {v0}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v5, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :cond_7
    :goto_5
    return-void
.end method

.method public b(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)Lcom/aliyun/ams/emas/push/notification/a;
    .locals 18
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ")",
            "Lcom/aliyun/ams/emas/push/notification/a;"
        }
    .end annotation

    move-object/from16 v0, p1

    const-string v1, "_ALIYUN_NOTIFICATION_MSG_ID_"

    const-string v2, "_ALIYUN_NOTIFICATION_PRIORITY_"

    const-string v3, "title"

    .line 78
    invoke-interface {v0, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    const-string v4, "content"

    .line 79
    invoke-interface {v0, v4}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    .line 80
    invoke-static {v3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    const-string v6, "MPS:MessageNotification"

    if-nez v5, :cond_9

    invoke-static {v4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    if-eqz v5, :cond_0

    goto/16 :goto_3

    .line 85
    :cond_0
    new-instance v5, Lcom/aliyun/ams/emas/push/notification/a;

    invoke-direct {v5}, Lcom/aliyun/ams/emas/push/notification/a;-><init>()V

    const-string v9, "open"

    .line 87
    invoke-interface {v0, v9}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/String;

    .line 88
    invoke-static {v9}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v10

    if-eqz v10, :cond_1

    const/4 v9, 0x1

    .line 89
    invoke-static {v9}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v9

    :cond_1
    const-string v10, "url"

    .line 91
    invoke-interface {v0, v10}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Ljava/lang/String;

    const-string v11, "activity"

    .line 92
    invoke-interface {v0, v11}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Ljava/lang/String;

    const-string v12, "ext"

    .line 93
    invoke-interface {v0, v12}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Ljava/lang/String;

    const-string v13, "task_id"

    .line 94
    invoke-interface {v0, v13}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Ljava/lang/String;

    const-string v14, "extData"

    .line 95
    invoke-interface {v0, v14}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v14

    check-cast v14, Ljava/lang/String;

    const-string v15, "notification_channel"

    .line 97
    invoke-interface {v0, v15}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v15

    check-cast v15, Ljava/lang/String;

    const-string v7, "notify_id"

    .line 98
    invoke-interface {v0, v7}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;

    const-string v8, "tid"

    .line 99
    invoke-interface {v0, v8}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/String;

    move-object/from16 v16, v6

    const-string v6, "badge"

    .line 100
    invoke-interface {v0, v6}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    .line 103
    invoke-static {v7}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v17

    if-nez v17, :cond_2

    .line 104
    invoke-static {v7}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v7

    goto :goto_0

    .line 106
    :cond_2
    invoke-static {}, Lcom/aliyun/ams/emas/push/h;->c()I

    move-result v7

    :goto_0
    move-object/from16 v17, v6

    move-object/from16 v6, p2

    .line 110
    invoke-virtual {v5, v6}, Lcom/aliyun/ams/emas/push/notification/a;->e(Ljava/lang/String;)V

    move-object/from16 v6, p3

    .line 112
    invoke-virtual {v5, v6}, Lcom/aliyun/ams/emas/push/notification/a;->d(Ljava/lang/String;)V

    .line 113
    invoke-virtual {v5, v13}, Lcom/aliyun/ams/emas/push/notification/a;->h(Ljava/lang/String;)V

    .line 114
    invoke-virtual {v5, v14}, Lcom/aliyun/ams/emas/push/notification/a;->i(Ljava/lang/String;)V

    const-string v6, "message_source"

    .line 115
    invoke-interface {v0, v6}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    invoke-virtual {v5, v6}, Lcom/aliyun/ams/emas/push/notification/a;->k(Ljava/lang/String;)V

    .line 117
    invoke-virtual {v5, v3}, Lcom/aliyun/ams/emas/push/notification/a;->a(Ljava/lang/String;)V

    .line 118
    invoke-virtual {v5, v4}, Lcom/aliyun/ams/emas/push/notification/a;->b(Ljava/lang/String;)V

    .line 119
    invoke-static {v9}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v3

    invoke-virtual {v5, v3}, Lcom/aliyun/ams/emas/push/notification/a;->a(I)V

    .line 120
    invoke-static {v10}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_3

    const/4 v10, 0x0

    :cond_3
    invoke-virtual {v5, v10}, Lcom/aliyun/ams/emas/push/notification/a;->c(Ljava/lang/String;)V

    .line 121
    invoke-static {v11}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_4

    const/4 v11, 0x0

    :cond_4
    invoke-virtual {v5, v11}, Lcom/aliyun/ams/emas/push/notification/a;->f(Ljava/lang/String;)V

    .line 122
    invoke-virtual {v5, v7}, Lcom/aliyun/ams/emas/push/notification/a;->b(I)V

    .line 123
    invoke-virtual {v5, v15}, Lcom/aliyun/ams/emas/push/notification/a;->j(Ljava/lang/String;)V

    .line 124
    invoke-virtual {v5, v8}, Lcom/aliyun/ams/emas/push/notification/a;->l(Ljava/lang/String;)V

    .line 126
    invoke-static {v12}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 128
    :try_start_0
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3, v12}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 129
    invoke-static {v3}, Lcom/taobao/accs/utl/JsonUtility;->toMap(Lorg/json/JSONObject;)Ljava/util/Map;

    move-result-object v3

    const-string v4, "_ALIYUN_NOTIFICATION_ID_"

    .line 132
    invoke-virtual {v5}, Lcom/aliyun/ams/emas/push/notification/a;->i()I

    move-result v6

    invoke-static {v6}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v6

    .line 131
    invoke-interface {v3, v4, v6}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 135
    invoke-interface {v3, v2}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_5

    .line 136
    invoke-interface {v3, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 138
    invoke-virtual {v5, v2}, Lcom/aliyun/ams/emas/push/notification/a;->g(Ljava/lang/String;)V

    goto :goto_1

    :cond_5
    const/4 v2, 0x0

    .line 141
    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v5, v4}, Lcom/aliyun/ams/emas/push/notification/a;->g(Ljava/lang/String;)V

    .line 150
    :goto_1
    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 149
    invoke-interface {v3, v1, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 152
    invoke-virtual {v5, v3}, Lcom/aliyun/ams/emas/push/notification/a;->a(Ljava/util/Map;)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    :catch_0
    move-exception v0

    const-string v1, "Parse inner json(ext) error:"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    move-object/from16 v3, v16

    .line 154
    invoke-static {v3, v1, v0, v2}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    .line 158
    :cond_6
    :goto_2
    invoke-static/range {v17 .. v17}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_8

    .line 159
    invoke-virtual {v5}, Lcom/aliyun/ams/emas/push/notification/a;->e()Ljava/util/Map;

    move-result-object v0

    if-nez v0, :cond_7

    .line 160
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    invoke-virtual {v5, v0}, Lcom/aliyun/ams/emas/push/notification/a;->a(Ljava/util/Map;)V

    .line 162
    :cond_7
    invoke-virtual {v5}, Lcom/aliyun/ams/emas/push/notification/a;->e()Ljava/util/Map;

    move-result-object v0

    const-string v1, "_ALIYUN_NOTIFICATION_BADGE_"

    move-object/from16 v6, v17

    invoke-interface {v0, v1, v6}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 163
    invoke-virtual {v5, v6}, Lcom/aliyun/ams/emas/push/notification/a;->n(Ljava/lang/String;)V

    :cond_8
    return-object v5

    :cond_9
    :goto_3
    move-object v3, v6

    .line 81
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "title or content of notify is empty: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v3, v0, v1}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const/4 v0, 0x0

    return-object v0
.end method
