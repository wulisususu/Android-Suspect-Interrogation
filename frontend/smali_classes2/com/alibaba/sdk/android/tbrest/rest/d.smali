.class public Lcom/alibaba/sdk/android/tbrest/rest/d;
.super Ljava/lang/Object;
.source "RestReqDataBuilder.java"


# static fields
.field private static final c:J

.field private static final d:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 28
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    sput-wide v0, Lcom/alibaba/sdk/android/tbrest/rest/d;->c:J

    .line 30
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lcom/alibaba/sdk/android/tbrest/rest/d;->d:Ljava/util/List;

    const-string v1, "IMEI"

    .line 33
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const-string v1, "IMSI"

    .line 34
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const-string v1, "BRAND"

    .line 35
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const-string v1, "DEVICE_MODEL"

    .line 36
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const-string v1, "RESOLUTION"

    .line 37
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const-string v1, "CARRIER"

    .line 38
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const-string v1, "ACCESS"

    .line 39
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const-string v1, "ACCESS_SUBTYPE"

    .line 40
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const-string v1, "CHANNEL"

    .line 41
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const-string v1, "APPKEY"

    .line 42
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const-string v1, "APPVERSION"

    .line 43
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const-string v1, "LL_USERNICK"

    .line 44
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const-string v1, "USERNICK"

    .line 45
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const-string v1, "LL_USERID"

    .line 46
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const-string v1, "USERID"

    .line 47
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const-string v1, "LANGUAGE"

    .line 48
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const-string v1, "OS"

    .line 49
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const-string v1, "OSVERSION"

    .line 50
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const-string v1, "SDKVERSION"

    .line 51
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const-string v1, "START_SESSION_TIMESTAMP"

    .line 52
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const-string v1, "UTDID"

    .line 53
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const-string v1, "SDKTYPE"

    .line 54
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const-string v1, "RESERVE2"

    .line 55
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const-string v1, "RESERVE3"

    .line 56
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const-string v1, "RESERVE4"

    .line 57
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const-string v1, "RESERVE5"

    .line 58
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const-string v1, "RESERVES"

    .line 59
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const-string v1, "RECORD_TIMESTAMP"

    .line 60
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const-string v1, "PAGE"

    .line 61
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const-string v1, "EVENTID"

    .line 62
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const-string v1, "ARG1"

    .line 63
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const-string v1, "ARG2"

    .line 64
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const-string v1, "ARG3"

    .line 65
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const-string v1, "ARGS"

    .line 66
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public static a(Lcom/alibaba/sdk/android/tbrest/SendService;Ljava/lang/String;Ljava/lang/String;Landroid/content/Context;JLjava/lang/String;ILjava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/util/Map;)Lcom/alibaba/sdk/android/tbrest/rest/c;
    .locals 32
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/alibaba/sdk/android/tbrest/SendService;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Landroid/content/Context;",
            "J",
            "Ljava/lang/String;",
            "I",
            "Ljava/lang/Object;",
            "Ljava/lang/Object;",
            "Ljava/lang/Object;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/alibaba/sdk/android/tbrest/rest/c;"
        }
    .end annotation

    move-object/from16 v0, p0

    const-string v1, "aliyunos"

    const-string/jumbo v2, "||-||-||-||-||"

    const-string/jumbo v3, "||mini||1.0||"

    const-string/jumbo v4, "||-||"

    const-string v5, "5.0.1||"

    const-string v6, ""

    const/4 v7, 0x0

    if-nez p7, :cond_0

    return-object v7

    .line 366
    :cond_0
    :try_start_0
    iget-object v8, v0, Lcom/alibaba/sdk/android/tbrest/SendService;->context:Landroid/content/Context;

    invoke-static {v8}, Lcom/alibaba/sdk/android/tbrest/utils/DeviceUtils;->getUtdid(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v8

    if-nez v8, :cond_1

    const-string v0, "get utdid failure, so build report failure, now return"

    .line 368
    invoke-static {v0}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->e(Ljava/lang/String;)V

    return-object v7

    .line 372
    :cond_1
    iget-object v9, v0, Lcom/alibaba/sdk/android/tbrest/SendService;->context:Landroid/content/Context;

    invoke-static {v9}, Lcom/alibaba/sdk/android/tbrest/utils/DeviceUtils;->getNetworkType(Landroid/content/Context;)[Ljava/lang/String;

    move-result-object v9

    const/4 v10, 0x0

    .line 373
    aget-object v10, v9, v10

    .line 375
    array-length v11, v9

    const/4 v12, 0x1

    if-le v11, v12, :cond_2

    if-eqz v10, :cond_2

    const-string v11, "Wi-Fi"

    invoke-virtual {v11, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v11

    if-nez v11, :cond_2

    .line 376
    aget-object v9, v9, v12

    goto :goto_0

    :cond_2
    move-object v9, v7

    :goto_0
    const-wide/16 v11, 0x0

    cmp-long v11, p4, v11

    if-lez v11, :cond_3

    move-wide/from16 v11, p4

    goto :goto_1

    .line 379
    :cond_3
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v11

    .line 380
    :goto_1
    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v13, v11, v12}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    .line 381
    new-instance v14, Ljava/text/SimpleDateFormat;

    const-string/jumbo v15, "yyyy-MM-dd HH:mm:ss"

    invoke-direct {v14, v15}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;)V

    .line 382
    invoke-static {v11, v12}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v11

    invoke-virtual {v14, v11}, Ljava/text/SimpleDateFormat;->format(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v11

    .line 383
    invoke-static/range {p6 .. p6}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    .line 384
    invoke-static/range {p7 .. p7}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v14

    invoke-static {v14}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v14

    .line 385
    invoke-static/range {p8 .. p8}, Lcom/alibaba/sdk/android/tbrest/utils/StringUtils;->convertObjectToString(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v15

    invoke-static {v15}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v15

    .line 386
    invoke-static/range {p9 .. p9}, Lcom/alibaba/sdk/android/tbrest/utils/StringUtils;->convertObjectToString(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v16

    invoke-static/range {v16 .. v16}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 387
    invoke-static/range {p10 .. p10}, Lcom/alibaba/sdk/android/tbrest/utils/StringUtils;->convertObjectToString(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v16

    move-object/from16 p4, v7

    invoke-static/range {v16 .. v16}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 388
    invoke-static/range {p11 .. p11}, Lcom/alibaba/sdk/android/tbrest/utils/StringUtils;->convertMapToString(Ljava/util/Map;)Ljava/lang/String;

    move-result-object v16

    move-object/from16 p5, v7

    invoke-static/range {v16 .. v16}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    move-object/from16 p6, v7

    .line 390
    iget-object v7, v0, Lcom/alibaba/sdk/android/tbrest/SendService;->context:Landroid/content/Context;

    invoke-static {v7}, Lcom/alibaba/sdk/android/tbrest/utils/DeviceUtils;->getImei(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    move-object/from16 p7, v15

    .line 391
    iget-object v15, v0, Lcom/alibaba/sdk/android/tbrest/SendService;->context:Landroid/content/Context;

    invoke-static {v15}, Lcom/alibaba/sdk/android/tbrest/utils/DeviceUtils;->getImsi(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v15

    invoke-static {v15}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v15

    .line 392
    sget-object v16, Landroid/os/Build;->BRAND:Ljava/lang/String;

    move-object/from16 v17, v14

    invoke-static/range {v16 .. v16}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v14

    .line 393
    invoke-static {}, Lcom/alibaba/sdk/android/tbrest/utils/DeviceUtils;->getCpuName()Ljava/lang/String;

    move-result-object v16

    move-object/from16 v18, v12

    invoke-static/range {v16 .. v16}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    move-object/from16 v16, v13

    .line 394
    invoke-static {v7}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v13

    .line 395
    sget-object v19, Landroid/os/Build;->MODEL:Ljava/lang/String;

    move-object/from16 v20, v11

    invoke-static/range {v19 .. v19}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    move-object/from16 v19, v2

    .line 396
    iget-object v2, v0, Lcom/alibaba/sdk/android/tbrest/SendService;->context:Landroid/content/Context;

    invoke-static {v2}, Lcom/alibaba/sdk/android/tbrest/utils/DeviceUtils;->getResolution(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    move-object/from16 v21, v3

    .line 397
    iget-object v3, v0, Lcom/alibaba/sdk/android/tbrest/SendService;->context:Landroid/content/Context;

    invoke-static {v3}, Lcom/alibaba/sdk/android/tbrest/utils/DeviceUtils;->getCarrier(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 398
    invoke-static {v10}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    .line 399
    invoke-static {v9}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    move-object/from16 v22, v4

    .line 400
    invoke-static/range {p1 .. p1}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    move-object/from16 p1, v4

    .line 401
    iget-object v4, v0, Lcom/alibaba/sdk/android/tbrest/SendService;->appVersion:Ljava/lang/String;

    invoke-static {v4}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    move-object/from16 p8, v4

    .line 402
    iget-object v4, v0, Lcom/alibaba/sdk/android/tbrest/SendService;->channel:Ljava/lang/String;

    invoke-static {v4}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    move-object/from16 p9, v4

    .line 404
    iget-object v4, v0, Lcom/alibaba/sdk/android/tbrest/SendService;->userNick:Ljava/lang/String;

    invoke-static {v4}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    move-object/from16 p10, v4

    .line 405
    iget-object v4, v0, Lcom/alibaba/sdk/android/tbrest/SendService;->userNick:Ljava/lang/String;

    invoke-static {v4}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 407
    invoke-static {}, Lcom/alibaba/sdk/android/tbrest/utils/DeviceUtils;->getCountry()Ljava/lang/String;

    move-result-object v23

    move-object/from16 p11, v4

    invoke-static/range {v23 .. v23}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 408
    invoke-static {}, Lcom/alibaba/sdk/android/tbrest/utils/DeviceUtils;->getLanguage()Ljava/lang/String;

    move-result-object v23

    move-object/from16 v24, v4

    invoke-static/range {v23 .. v23}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 409
    iget-object v0, v0, Lcom/alibaba/sdk/android/tbrest/SendService;->appId:Ljava/lang/String;

    const-string v23, "Android"

    if-eqz v0, :cond_4

    .line 412
    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_4

    goto :goto_2

    :cond_4
    move-object/from16 v1, v23

    .line 415
    :goto_2
    sget-object v0, Landroid/os/Build$VERSION;->RELEASE:Ljava/lang/String;

    invoke-static {v0}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    move-object/from16 p0, v0

    .line 418
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    move-object/from16 v25, v9

    move-object/from16 v23, v10

    sget-wide v9, Lcom/alibaba/sdk/android/tbrest/rest/d;->c:J

    invoke-virtual {v0, v9, v10}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 419
    invoke-static {v8}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    .line 425
    invoke-static {v6}, Lcom/alibaba/sdk/android/tbrest/utils/StringUtils;->isBlank(Ljava/lang/CharSequence;)Z

    .line 429
    new-instance v6, Ljava/lang/StringBuffer;

    invoke-direct {v6, v5}, Ljava/lang/StringBuffer;-><init>(Ljava/lang/String;)V

    const-string/jumbo v5, "||"

    .line 434
    invoke-virtual {v6, v7}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v7

    invoke-virtual {v7, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 435
    invoke-virtual {v6, v15}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v7

    invoke-virtual {v7, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 436
    invoke-virtual {v6, v14}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v7

    invoke-virtual {v7, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 437
    invoke-virtual {v6, v12}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v7

    invoke-virtual {v7, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 438
    invoke-virtual {v6, v13}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v7

    invoke-virtual {v7, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 439
    invoke-virtual {v6, v11}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v7

    invoke-virtual {v7, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 440
    invoke-virtual {v6, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v2

    invoke-virtual {v2, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 441
    invoke-virtual {v6, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v2

    invoke-virtual {v2, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-object/from16 v2, v23

    .line 442
    invoke-virtual {v6, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v2

    invoke-virtual {v2, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-object/from16 v2, v25

    .line 443
    invoke-virtual {v6, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v2

    invoke-virtual {v2, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-object/from16 v2, p9

    .line 444
    invoke-virtual {v6, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v3

    invoke-virtual {v3, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-object/from16 v3, p1

    .line 445
    invoke-virtual {v6, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v7

    invoke-virtual {v7, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-object/from16 v7, p8

    .line 446
    invoke-virtual {v6, v7}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v9

    invoke-virtual {v9, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-object/from16 v9, p10

    .line 447
    invoke-virtual {v6, v9}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v9

    invoke-virtual {v9, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-object/from16 v9, p11

    .line 448
    invoke-virtual {v6, v9}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v9

    move-object/from16 v10, v22

    invoke-virtual {v9, v10}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-object/from16 v9, v24

    .line 450
    invoke-virtual {v6, v9}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v9

    invoke-virtual {v9, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 451
    invoke-virtual {v6, v4}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v4

    invoke-virtual {v4, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 452
    invoke-virtual {v6, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v4

    invoke-virtual {v4, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-object/from16 v4, p0

    .line 453
    invoke-virtual {v6, v4}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v4

    move-object/from16 v9, v21

    invoke-virtual {v4, v9}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 456
    invoke-virtual {v6, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v0

    invoke-virtual {v0, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 457
    invoke-virtual {v6, v8}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v0

    move-object/from16 v4, v19

    invoke-virtual {v0, v4}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-object/from16 v0, v20

    .line 462
    invoke-virtual {v6, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v0

    invoke-virtual {v0, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-object/from16 v0, v16

    .line 463
    invoke-virtual {v6, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v0

    invoke-virtual {v0, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-object/from16 v0, v18

    .line 464
    invoke-virtual {v6, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v0

    invoke-virtual {v0, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-object/from16 v0, v17

    .line 465
    invoke-virtual {v6, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v0

    invoke-virtual {v0, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-object/from16 v0, p7

    .line 466
    invoke-virtual {v6, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v0

    invoke-virtual {v0, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-object/from16 v0, p4

    .line 467
    invoke-virtual {v6, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v0

    invoke-virtual {v0, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-object/from16 v0, p5

    .line 468
    invoke-virtual {v6, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v0

    invoke-virtual {v0, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-object/from16 v0, p6

    .line 469
    invoke-virtual {v6, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 471
    invoke-virtual {v6}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    .line 472
    new-instance v4, Ljava/util/HashMap;

    invoke-direct {v4}, Ljava/util/HashMap;-><init>()V

    .line 473
    invoke-virtual {v0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    const-string v5, "stm_x"

    .line 474
    invoke-interface {v4, v5, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 476
    new-instance v0, Lcom/alibaba/sdk/android/tbrest/rest/c;

    invoke-direct {v0}, Lcom/alibaba/sdk/android/tbrest/rest/c;-><init>()V

    const/16 v23, 0x0

    const-string v30, ""

    move-object/from16 v22, p2

    move-object/from16 v24, v4

    move-object/from16 v25, p3

    move-object/from16 v26, v3

    move-object/from16 v27, v2

    move-object/from16 v28, v7

    move-object/from16 v29, v1

    move-object/from16 v31, v8

    .line 477
    invoke-static/range {v22 .. v31}, Lcom/alibaba/sdk/android/tbrest/rest/RestUrlWrapper;->getSignedTransferUrl(Ljava/lang/String;Ljava/util/Map;Ljava/util/Map;Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 480
    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/tbrest/rest/c;->b(Ljava/lang/String;)V

    .line 481
    invoke-virtual {v0, v4}, Lcom/alibaba/sdk/android/tbrest/rest/c;->a(Ljava/util/Map;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    move-exception v0

    const-string v1, "UTRestAPI buildTracePostReqDataObj catch!"

    .line 485
    invoke-static {v1, v0}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    const/4 v1, 0x0

    return-object v1
.end method

.method public static a(Lcom/alibaba/sdk/android/tbrest/SendService;Ljava/lang/String;JLjava/lang/String;ILjava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/util/Map;)Ljava/lang/String;
    .locals 23
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/alibaba/sdk/android/tbrest/SendService;",
            "Ljava/lang/String;",
            "J",
            "Ljava/lang/String;",
            "I",
            "Ljava/lang/Object;",
            "Ljava/lang/Object;",
            "Ljava/lang/Object;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Ljava/lang/String;"
        }
    .end annotation

    move-object/from16 v0, p0

    const-string v1, "-"

    const-string v2, ""

    const/4 v3, 0x0

    if-nez p5, :cond_0

    return-object v3

    .line 107
    :cond_0
    :try_start_0
    iget-object v4, v0, Lcom/alibaba/sdk/android/tbrest/SendService;->context:Landroid/content/Context;

    invoke-static {v4}, Lcom/alibaba/sdk/android/tbrest/utils/DeviceUtils;->getUtdid(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_1

    const-string v0, "get utdid failure, so build report failure, now return"

    .line 109
    invoke-static {v0}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->e(Ljava/lang/String;)V

    return-object v3

    .line 113
    :cond_1
    iget-object v5, v0, Lcom/alibaba/sdk/android/tbrest/SendService;->context:Landroid/content/Context;

    invoke-static {v5}, Lcom/alibaba/sdk/android/tbrest/utils/DeviceUtils;->getNetworkType(Landroid/content/Context;)[Ljava/lang/String;

    move-result-object v5

    const/4 v6, 0x0

    .line 114
    aget-object v6, v5, v6

    .line 116
    array-length v7, v5

    const/4 v8, 0x1

    if-le v7, v8, :cond_2

    if-eqz v6, :cond_2

    const-string v7, "Wi-Fi"

    invoke-virtual {v7, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_2

    .line 117
    aget-object v3, v5, v8

    :cond_2
    const-wide/16 v7, 0x0

    cmp-long v5, p2, v7

    if-lez v5, :cond_3

    move-wide/from16 v7, p2

    goto :goto_0

    .line 120
    :cond_3
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v7

    .line 121
    :goto_0
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5, v7, v8}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .line 123
    invoke-static/range {p4 .. p4}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 124
    invoke-static/range {p5 .. p5}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v8

    invoke-static {v8}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    .line 125
    invoke-static/range {p6 .. p6}, Lcom/alibaba/sdk/android/tbrest/utils/StringUtils;->convertObjectToString(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v9

    invoke-static {v9}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    .line 126
    invoke-static/range {p7 .. p7}, Lcom/alibaba/sdk/android/tbrest/utils/StringUtils;->convertObjectToString(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v10

    invoke-static {v10}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    .line 127
    invoke-static/range {p8 .. p8}, Lcom/alibaba/sdk/android/tbrest/utils/StringUtils;->convertObjectToString(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v11

    invoke-static {v11}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    .line 128
    invoke-static/range {p9 .. p9}, Lcom/alibaba/sdk/android/tbrest/utils/StringUtils;->convertMapToString(Ljava/util/Map;)Ljava/lang/String;

    move-result-object v12

    invoke-static {v12}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    .line 130
    iget-object v13, v0, Lcom/alibaba/sdk/android/tbrest/SendService;->context:Landroid/content/Context;

    invoke-static {v13}, Lcom/alibaba/sdk/android/tbrest/utils/DeviceUtils;->getImei(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v13

    invoke-static {v13}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v13

    .line 131
    iget-object v14, v0, Lcom/alibaba/sdk/android/tbrest/SendService;->context:Landroid/content/Context;

    invoke-static {v14}, Lcom/alibaba/sdk/android/tbrest/utils/DeviceUtils;->getImsi(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v14

    invoke-static {v14}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v14

    .line 132
    invoke-virtual/range {p0 .. p0}, Lcom/alibaba/sdk/android/tbrest/SendService;->getNoCollectionDataType()I

    move-result v15

    invoke-static {v15}, Lcom/alibaba/sdk/android/tbrest/rest/NoCollectionDataType;->isNoDeviceData(I)Z

    move-result v15

    if-eqz v15, :cond_4

    move-object v15, v2

    goto :goto_1

    :cond_4
    sget-object v15, Landroid/os/Build;->BRAND:Ljava/lang/String;

    :goto_1
    invoke-static {v15}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v15

    .line 135
    invoke-virtual/range {p0 .. p0}, Lcom/alibaba/sdk/android/tbrest/SendService;->getNoCollectionDataType()I

    move-result v16

    invoke-static/range {v16 .. v16}, Lcom/alibaba/sdk/android/tbrest/rest/NoCollectionDataType;->isNoDeviceData(I)Z

    move-result v16

    if-eqz v16, :cond_5

    move-object/from16 v16, v2

    goto :goto_2

    :cond_5
    sget-object v16, Landroid/os/Build;->MODEL:Ljava/lang/String;

    :goto_2
    move-object/from16 v17, v3

    invoke-static/range {v16 .. v16}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 136
    invoke-virtual/range {p0 .. p0}, Lcom/alibaba/sdk/android/tbrest/SendService;->getNoCollectionDataType()I

    move-result v16

    invoke-static/range {v16 .. v16}, Lcom/alibaba/sdk/android/tbrest/rest/NoCollectionDataType;->isNoDeviceData(I)Z

    move-result v16

    if-eqz v16, :cond_6

    move-object/from16 v16, v6

    move-object v6, v2

    goto :goto_3

    :cond_6
    move-object/from16 v16, v6

    iget-object v6, v0, Lcom/alibaba/sdk/android/tbrest/SendService;->context:Landroid/content/Context;

    invoke-static {v6}, Lcom/alibaba/sdk/android/tbrest/utils/DeviceUtils;->getResolution(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v6

    :goto_3
    invoke-static {v6}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 137
    invoke-virtual/range {p0 .. p0}, Lcom/alibaba/sdk/android/tbrest/SendService;->getNoCollectionDataType()I

    move-result v18

    invoke-static/range {v18 .. v18}, Lcom/alibaba/sdk/android/tbrest/rest/NoCollectionDataType;->isNoNetworkData(I)Z

    move-result v18

    if-eqz v18, :cond_7

    move-object/from16 p2, v12

    move-object v12, v2

    goto :goto_4

    :cond_7
    move-object/from16 p2, v12

    iget-object v12, v0, Lcom/alibaba/sdk/android/tbrest/SendService;->context:Landroid/content/Context;

    invoke-static {v12}, Lcom/alibaba/sdk/android/tbrest/utils/DeviceUtils;->getCarrier(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v12

    :goto_4
    invoke-static {v12}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    .line 138
    invoke-virtual/range {p0 .. p0}, Lcom/alibaba/sdk/android/tbrest/SendService;->getNoCollectionDataType()I

    move-result v18

    invoke-static/range {v18 .. v18}, Lcom/alibaba/sdk/android/tbrest/rest/NoCollectionDataType;->isNoNetworkData(I)Z

    move-result v18

    if-eqz v18, :cond_8

    move-object/from16 v16, v2

    :cond_8
    move-object/from16 p3, v11

    invoke-static/range {v16 .. v16}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    .line 139
    invoke-virtual/range {p0 .. p0}, Lcom/alibaba/sdk/android/tbrest/SendService;->getNoCollectionDataType()I

    move-result v16

    invoke-static/range {v16 .. v16}, Lcom/alibaba/sdk/android/tbrest/rest/NoCollectionDataType;->isNoNetworkData(I)Z

    move-result v16

    if-eqz v16, :cond_9

    move-object/from16 v17, v2

    :cond_9
    move-object/from16 p4, v10

    invoke-static/range {v17 .. v17}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    move-object/from16 p5, v9

    .line 140
    invoke-static/range {p1 .. p1}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    move-object/from16 v16, v8

    .line 141
    iget-object v8, v0, Lcom/alibaba/sdk/android/tbrest/SendService;->appVersion:Ljava/lang/String;

    invoke-static {v8}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    move-object/from16 v17, v7

    .line 142
    iget-object v7, v0, Lcom/alibaba/sdk/android/tbrest/SendService;->channel:Ljava/lang/String;

    invoke-static {v7}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    move-object/from16 v18, v5

    .line 144
    iget-object v5, v0, Lcom/alibaba/sdk/android/tbrest/SendService;->userNick:Ljava/lang/String;

    invoke-static {v5}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_2

    move-object/from16 v19, v2

    .line 145
    :try_start_1
    iget-object v2, v0, Lcom/alibaba/sdk/android/tbrest/SendService;->userNick:Ljava/lang/String;

    invoke-static {v2}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 148
    invoke-virtual/range {p0 .. p0}, Lcom/alibaba/sdk/android/tbrest/SendService;->getNoCollectionDataType()I

    move-result v20

    invoke-static/range {v20 .. v20}, Lcom/alibaba/sdk/android/tbrest/rest/NoCollectionDataType;->isNoOsData(I)Z

    move-result v20

    if-eqz v20, :cond_a

    move-object/from16 v21, v1

    move-object/from16 v20, v19

    goto :goto_5

    :cond_a
    invoke-static {}, Lcom/alibaba/sdk/android/tbrest/utils/DeviceUtils;->getLanguage()Ljava/lang/String;

    move-result-object v20

    move-object/from16 v21, v1

    :goto_5
    invoke-static/range {v20 .. v20}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    move-object/from16 p1, v1

    .line 149
    iget-object v1, v0, Lcom/alibaba/sdk/android/tbrest/SendService;->appId:Ljava/lang/String;

    const-string v20, "a"

    .line 154
    invoke-virtual/range {p0 .. p0}, Lcom/alibaba/sdk/android/tbrest/SendService;->getNoCollectionDataType()I

    move-result v22

    invoke-static/range {v22 .. v22}, Lcom/alibaba/sdk/android/tbrest/rest/NoCollectionDataType;->isNoOsData(I)Z

    move-result v22

    if-eqz v22, :cond_b

    move-object/from16 p6, v2

    move-object/from16 v22, v19

    goto :goto_6

    :cond_b
    sget-object v22, Landroid/os/Build$VERSION;->RELEASE:Ljava/lang/String;

    move-object/from16 p6, v2

    :goto_6
    invoke-static/range {v22 .. v22}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    move-object/from16 p7, v2

    const-string v2, "mini"

    move-object/from16 p8, v2

    const-string v2, "1.0"

    .line 158
    invoke-static {v4}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 162
    iget-object v0, v0, Lcom/alibaba/sdk/android/tbrest/SendService;->country:Ljava/lang/String;

    invoke-static {v0}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v1, :cond_c

    move-object/from16 p0, v0

    const-string v0, "aliyunos"

    .line 171
    invoke-virtual {v1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_d

    const-string/jumbo v20, "y"

    goto :goto_7

    :cond_c
    move-object/from16 p0, v0

    :cond_d
    :goto_7
    move-object/from16 v0, v20

    .line 175
    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    move-object/from16 p9, v4

    const-string v4, "IMEI"

    .line 176
    invoke-interface {v1, v4, v13}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v4, "IMSI"

    .line 177
    invoke-interface {v1, v4, v14}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v4, "BRAND"

    .line 178
    invoke-interface {v1, v4, v15}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v4, "DEVICE_MODEL"

    .line 179
    invoke-interface {v1, v4, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v3, "RESOLUTION"

    .line 180
    invoke-interface {v1, v3, v6}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v3, "CARRIER"

    .line 181
    invoke-interface {v1, v3, v12}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v3, "ACCESS"

    .line 182
    invoke-interface {v1, v3, v11}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v3, "ACCESS_SUBTYPE"

    .line 183
    invoke-interface {v1, v3, v10}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v3, "CHANNEL"

    .line 184
    invoke-interface {v1, v3, v7}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v3, "APPKEY"

    .line 185
    invoke-interface {v1, v3, v9}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v3, "APPVERSION"

    .line 186
    invoke-interface {v1, v3, v8}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v3, "LL_USERNICK"

    .line 187
    invoke-interface {v1, v3, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v3, "USERNICK"

    move-object/from16 v4, p6

    .line 188
    invoke-interface {v1, v3, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v3, "LL_USERID"

    move-object/from16 v4, v21

    .line 189
    invoke-interface {v1, v3, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v3, "USERID"

    .line 190
    invoke-interface {v1, v3, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v3, "LANGUAGE"

    move-object/from16 v5, p1

    .line 191
    invoke-interface {v1, v3, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v3, "OS"

    .line 192
    invoke-interface {v1, v3, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "OSVERSION"

    move-object/from16 v3, p7

    .line 193
    invoke-interface {v1, v0, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "SDKVERSION"

    .line 194
    invoke-interface {v1, v0, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "START_SESSION_TIMESTAMP"

    .line 195
    new-instance v2, Ljava/lang/StringBuilder;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    move-object/from16 v3, v19

    :try_start_2
    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    sget-wide v5, Lcom/alibaba/sdk/android/tbrest/rest/d;->c:J

    invoke-virtual {v2, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1, v0, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "UTDID"

    move-object/from16 v2, p9

    .line 196
    invoke-interface {v1, v0, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "SDKTYPE"

    move-object/from16 v5, p8

    .line 197
    invoke-interface {v1, v0, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "RESERVE2"

    .line 198
    invoke-interface {v1, v0, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "RESERVE3"

    .line 199
    invoke-interface {v1, v0, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "RESERVE4"

    .line 200
    invoke-interface {v1, v0, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "RESERVE5"

    .line 201
    invoke-interface {v1, v0, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "RESERVES"

    move-object/from16 v2, p0

    .line 202
    invoke-interface {v1, v0, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "RECORD_TIMESTAMP"

    move-object/from16 v2, v18

    .line 203
    invoke-interface {v1, v0, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "PAGE"

    move-object/from16 v2, v17

    .line 204
    invoke-interface {v1, v0, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "EVENTID"

    move-object/from16 v2, v16

    .line 205
    invoke-interface {v1, v0, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "ARG1"

    move-object/from16 v2, p5

    .line 206
    invoke-interface {v1, v0, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "ARG2"

    move-object/from16 v2, p4

    .line 207
    invoke-interface {v1, v0, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "ARG3"

    move-object/from16 v2, p3

    .line 208
    invoke-interface {v1, v0, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "ARGS"

    move-object/from16 v2, p2

    .line 209
    invoke-interface {v1, v0, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 211
    invoke-static {v1}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/util/Map;)Ljava/lang/String;

    move-result-object v0
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    return-object v0

    :catch_0
    move-exception v0

    goto :goto_8

    :catch_1
    move-exception v0

    move-object/from16 v3, v19

    goto :goto_8

    :catch_2
    move-exception v0

    move-object v3, v2

    :goto_8
    const-string v1, "UTRestAPI buildTracePostReqDataObj catch!"

    .line 213
    invoke-static {v1, v0}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    return-object v3
.end method

.method private static a(Ljava/lang/String;)Ljava/lang/String;
    .locals 5

    .line 70
    invoke-static {p0}, Lcom/alibaba/sdk/android/tbrest/utils/StringUtils;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string p0, "-"

    return-object p0

    :cond_0
    const-string v0, ""

    .line 73
    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_4

    .line 77
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(I)V

    .line 78
    invoke-virtual {p0}, Ljava/lang/String;->toCharArray()[C

    move-result-object p0

    .line 79
    array-length v1, p0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_3

    aget-char v3, p0, v2

    const/16 v4, 0xa

    if-eq v3, v4, :cond_2

    const/16 v4, 0xd

    if-eq v3, v4, :cond_2

    const/16 v4, 0x9

    if-eq v3, v4, :cond_2

    const/16 v4, 0x7c

    if-ne v3, v4, :cond_1

    goto :goto_1

    .line 83
    :cond_1
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    :cond_2
    :goto_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 86
    :cond_3
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    :cond_4
    return-object p0
.end method

.method public static a(Ljava/util/Map;)Ljava/lang/String;
    .locals 10
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Ljava/lang/String;"
        }
    .end annotation

    .line 226
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Lcom/alibaba/sdk/android/tbrest/rest/d;->d:Ljava/util/List;

    .line 227
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    const-string/jumbo v3, "||"

    const/4 v4, 0x0

    const-string v5, "ARGS"

    if-eqz v2, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 228
    invoke-virtual {v5, v2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_0

    goto :goto_2

    .line 233
    :cond_0
    invoke-interface {p0, v2}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1

    .line 235
    invoke-interface {p0, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    .line 236
    invoke-interface {p0, v2}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_1

    .line 238
    :cond_1
    new-instance v5, Ljava/lang/StringBuilder;

    const-string v6, "ReqDataBuilder: assembleWithFullFields logMap not containsKey: "

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->d(Ljava/lang/String;)V

    .line 240
    :goto_1
    invoke-static {v4}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_0

    .line 245
    :cond_2
    :goto_2
    invoke-interface {p0, v5}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v1

    const/4 v2, 0x0

    if-eqz v1, :cond_3

    .line 246
    invoke-interface {p0, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    invoke-static {v1}, Lcom/alibaba/sdk/android/tbrest/utils/StringUtils;->convertObjectToString(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 247
    invoke-static {v1}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 248
    invoke-interface {p0, v5}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move v1, v2

    goto :goto_3

    :cond_3
    const/4 v1, 0x1

    .line 252
    :goto_3
    invoke-interface {p0}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v5

    invoke-interface {v5}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :goto_4
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_8

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    .line 254
    invoke-interface {p0, v6}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_4

    .line 255
    invoke-interface {p0, v6}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    invoke-static {v7}, Lcom/alibaba/sdk/android/tbrest/utils/StringUtils;->convertObjectToString(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    goto :goto_5

    :cond_4
    move-object v7, v4

    :goto_5
    const-string v8, "="

    const-string v9, "StackTrace"

    if-eqz v1, :cond_6

    .line 259
    invoke-virtual {v9, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_5

    const-string v1, "StackTrace=====>"

    .line 260
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_6

    .line 262
    :cond_5
    invoke-static {v6}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :goto_6
    move v1, v2

    goto :goto_4

    .line 267
    :cond_6
    invoke-virtual {v9, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_7

    const-string v6, ",StackTrace=====>"

    .line 268
    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_4

    :cond_7
    const-string v9, ","

    .line 270
    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-static {v6}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v9, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_4

    .line 276
    :cond_8
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    .line 277
    invoke-static {p0}, Lcom/alibaba/sdk/android/tbrest/utils/StringUtils;->isEmpty(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_9

    .line 278
    invoke-virtual {p0, v3}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_9

    .line 279
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v0, "-"

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    :cond_9
    return-object p0
.end method
