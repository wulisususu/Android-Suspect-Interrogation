.class Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$JavaExceptionReportBuilder;
.super Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$SimpleJavaExceptionReportBuilder;
.source "BizErrorBuilder.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "JavaExceptionReportBuilder"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder;


# direct methods
.method constructor <init>(Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder;Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;Landroid/content/Context;Ljava/lang/String;JLjava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010,
            0x0,
            0x0,
            0x0,
            0x0,
            0x0
        }
        names = {
            "this$0",
            "exceptionModule",
            "context",
            "reportName",
            "timestamp",
            "type"
        }
    .end annotation

    iput-object p1, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$JavaExceptionReportBuilder;->this$0:Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder;

    .line 475
    invoke-direct/range {p0 .. p7}, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$SimpleJavaExceptionReportBuilder;-><init>(Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder;Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;Landroid/content/Context;Ljava/lang/String;JLjava/lang/String;)V

    return-void
.end method


# virtual methods
.method protected buildContent()Ljava/lang/String;
    .locals 2

    .line 480
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 482
    invoke-virtual {p0}, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$JavaExceptionReportBuilder;->buildThrowable()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 483
    invoke-virtual {p0}, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$JavaExceptionReportBuilder;->buildExtraInfo()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 484
    invoke-virtual {p0}, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$JavaExceptionReportBuilder;->buildUserInfo()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 485
    invoke-virtual {p0}, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$JavaExceptionReportBuilder;->buildStatus()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 486
    invoke-virtual {p0}, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$JavaExceptionReportBuilder;->buildStorageinfo()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 487
    invoke-virtual {p0}, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$JavaExceptionReportBuilder;->buildFileDescriptor()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 489
    iget-object v1, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$JavaExceptionReportBuilder;->mThrowable:Ljava/lang/Throwable;

    instance-of v1, v1, Ljava/lang/OutOfMemoryError;

    if-eqz v1, :cond_0

    .line 490
    invoke-virtual {p0}, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$JavaExceptionReportBuilder;->buildApplictionMeminfo()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 492
    :cond_0
    invoke-virtual {p0}, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$JavaExceptionReportBuilder;->buildLogcat()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 494
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method protected buildUserInfo()Ljava/lang/String;
    .locals 15

    .line 498
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "userinfo:\n"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 502
    invoke-static {}, Lcom/alibaba/sdk/android/tbrest/SendService;->getInstance()Lcom/alibaba/sdk/android/tbrest/SendService;

    move-result-object v1

    iget-object v1, v1, Lcom/alibaba/sdk/android/tbrest/SendService;->appKey:Ljava/lang/String;

    invoke-static {}, Lcom/alibaba/sdk/android/tbrest/SendService;->getInstance()Lcom/alibaba/sdk/android/tbrest/SendService;

    move-result-object v2

    iget-object v2, v2, Lcom/alibaba/sdk/android/tbrest/SendService;->userNick:Ljava/lang/String;

    invoke-static {v1, v2}, Lcom/alibaba/sdk/android/tool/CryptUtils;->aesGcmEncrypt(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 503
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    const-string v3, "%s: %s\n"

    if-nez v2, :cond_0

    const-string v2, "userNick"

    .line 504
    filled-new-array {v2, v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v3, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 507
    :cond_0
    invoke-static {}, Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;->getInstance()Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;

    move-result-object v1

    invoke-virtual {v1}, Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;->getCustomInfo()Ljava/util/Map;

    move-result-object v1

    const/4 v2, 0x1

    const/16 v4, 0x2800

    const/4 v5, 0x2

    const-string v6, "utf-8"

    const/4 v7, 0x0

    if-eqz v1, :cond_5

    .line 508
    invoke-interface {v1}, Ljava/util/Map;->isEmpty()Z

    move-result v8

    if-nez v8, :cond_5

    .line 509
    new-instance v8, Lorg/json/JSONObject;

    invoke-direct {v8}, Lorg/json/JSONObject;-><init>()V

    .line 513
    :try_start_0
    invoke-interface {v1}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v9

    invoke-interface {v9}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v9

    move v10, v7

    :cond_1
    :goto_0
    invoke-interface {v9}, Ljava/util/Iterator;->hasNext()Z

    move-result v11

    if-eqz v11, :cond_4

    invoke-interface {v9}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Ljava/lang/String;

    .line 514
    invoke-interface {v1, v11}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Ljava/lang/String;

    .line 515
    invoke-static {v11}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v13

    if-eqz v13, :cond_2

    move v13, v7

    goto :goto_1

    :cond_2
    invoke-virtual {v11, v6}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v13

    array-length v13, v13

    .line 516
    :goto_1
    invoke-static {v12}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v14

    if-eqz v14, :cond_3

    move v14, v7

    goto :goto_2

    :cond_3
    invoke-virtual {v12, v6}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v14

    array-length v14, v14

    :goto_2
    add-int/2addr v13, v14

    add-int/2addr v13, v10

    if-gt v13, v4, :cond_1

    .line 518
    invoke-virtual {v8, v11, v12}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move v10, v13

    goto :goto_0

    .line 523
    :cond_4
    invoke-virtual {v8}, Lorg/json/JSONObject;->length()I

    move-result v1

    if-lez v1, :cond_5

    .line 524
    invoke-static {}, Lcom/alibaba/sdk/android/tbrest/SendService;->getInstance()Lcom/alibaba/sdk/android/tbrest/SendService;

    move-result-object v1

    iget-object v1, v1, Lcom/alibaba/sdk/android/tbrest/SendService;->appKey:Ljava/lang/String;

    invoke-virtual {v8}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v1, v8}, Lcom/alibaba/sdk/android/tool/CryptUtils;->aesGcmEncrypt(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 526
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v8

    if-nez v8, :cond_5

    new-array v8, v5, [Ljava/lang/Object;

    const-string v9, "customInfo"

    aput-object v9, v8, v7

    aput-object v1, v8, v2

    .line 527
    invoke-static {v3, v8}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 535
    :catch_0
    :cond_5
    invoke-static {}, Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;->getInstance()Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;

    move-result-object v1

    invoke-virtual {v1}, Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;->getErrorCallback()Lcom/alibaba/ha/protocol/crash/ErrorCallback;

    move-result-object v1

    if-eqz v1, :cond_a

    .line 536
    new-instance v1, Lcom/alibaba/ha/protocol/crash/ErrorInfo;

    invoke-direct {v1}, Lcom/alibaba/ha/protocol/crash/ErrorInfo;-><init>()V

    .line 537
    iget-object v8, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$JavaExceptionReportBuilder;->mExceptionModule:Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;

    iget v8, v8, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->errorType:I

    invoke-virtual {v1, v8}, Lcom/alibaba/ha/protocol/crash/ErrorInfo;->setErrorType(I)V

    .line 538
    iget-object v8, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$JavaExceptionReportBuilder;->mExceptionModule:Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;

    iget-object v8, v8, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->throwable:Ljava/lang/Throwable;

    invoke-virtual {v1, v8}, Lcom/alibaba/ha/protocol/crash/ErrorInfo;->setThrowable(Ljava/lang/Throwable;)V

    .line 540
    :try_start_1
    invoke-static {}, Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;->getInstance()Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;

    move-result-object v8

    invoke-virtual {v8}, Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;->getErrorCallback()Lcom/alibaba/ha/protocol/crash/ErrorCallback;

    move-result-object v8

    invoke-interface {v8, v1}, Lcom/alibaba/ha/protocol/crash/ErrorCallback;->onError(Lcom/alibaba/ha/protocol/crash/ErrorInfo;)Ljava/util/Map;

    move-result-object v1

    if-eqz v1, :cond_a

    .line 541
    invoke-interface {v1}, Ljava/util/Map;->isEmpty()Z

    move-result v8

    if-nez v8, :cond_a

    .line 542
    new-instance v8, Lorg/json/JSONObject;

    invoke-direct {v8}, Lorg/json/JSONObject;-><init>()V

    .line 546
    invoke-interface {v1}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v9

    invoke-interface {v9}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v9

    move v10, v7

    :cond_6
    :goto_3
    invoke-interface {v9}, Ljava/util/Iterator;->hasNext()Z

    move-result v11

    if-eqz v11, :cond_9

    invoke-interface {v9}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Ljava/lang/String;

    .line 547
    invoke-interface {v1, v11}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Ljava/lang/String;

    .line 548
    invoke-static {v11}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v13

    if-eqz v13, :cond_7

    move v13, v7

    goto :goto_4

    :cond_7
    invoke-virtual {v11, v6}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v13

    array-length v13, v13

    .line 549
    :goto_4
    invoke-static {v12}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v14

    if-eqz v14, :cond_8

    move v14, v7

    goto :goto_5

    :cond_8
    invoke-virtual {v12, v6}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v14

    array-length v14, v14

    :goto_5
    add-int/2addr v13, v14

    add-int/2addr v13, v10

    if-gt v13, v4, :cond_6

    .line 551
    invoke-virtual {v8, v11, v12}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move v10, v13

    goto :goto_3

    .line 556
    :cond_9
    invoke-virtual {v8}, Lorg/json/JSONObject;->length()I

    move-result v1

    if-lez v1, :cond_a

    .line 557
    invoke-static {}, Lcom/alibaba/sdk/android/tbrest/SendService;->getInstance()Lcom/alibaba/sdk/android/tbrest/SendService;

    move-result-object v1

    iget-object v1, v1, Lcom/alibaba/sdk/android/tbrest/SendService;->appKey:Ljava/lang/String;

    invoke-virtual {v8}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v1, v8}, Lcom/alibaba/sdk/android/tool/CryptUtils;->aesGcmEncrypt(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 559
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v8

    if-nez v8, :cond_a

    new-array v8, v5, [Ljava/lang/Object;

    const-string v9, "crashInfo"

    aput-object v9, v8, v7

    aput-object v1, v8, v2

    .line 560
    invoke-static {v3, v8}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 569
    :catchall_0
    :cond_a
    iget-object v1, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$JavaExceptionReportBuilder;->mExceptionModule:Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;

    iget-object v1, v1, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->crossPlatformCrashInfo:Ljava/util/Map;

    if-eqz v1, :cond_f

    iget-object v1, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$JavaExceptionReportBuilder;->mExceptionModule:Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;

    iget-object v1, v1, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->crossPlatformCrashInfo:Ljava/util/Map;

    invoke-interface {v1}, Ljava/util/Map;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_f

    .line 571
    :try_start_2
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 574
    iget-object v8, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$JavaExceptionReportBuilder;->mExceptionModule:Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;

    iget-object v8, v8, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->crossPlatformCrashInfo:Ljava/util/Map;

    invoke-interface {v8}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v8

    invoke-interface {v8}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v8

    move v9, v7

    :cond_b
    :goto_6
    invoke-interface {v8}, Ljava/util/Iterator;->hasNext()Z

    move-result v10

    if-eqz v10, :cond_e

    invoke-interface {v8}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Ljava/lang/String;

    .line 575
    iget-object v11, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$JavaExceptionReportBuilder;->mExceptionModule:Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;

    iget-object v11, v11, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->crossPlatformCrashInfo:Ljava/util/Map;

    invoke-interface {v11, v10}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Ljava/lang/String;

    .line 576
    invoke-static {v10}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v12

    if-eqz v12, :cond_c

    move v12, v7

    goto :goto_7

    :cond_c
    invoke-virtual {v10, v6}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v12

    array-length v12, v12

    .line 577
    :goto_7
    invoke-static {v11}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v13

    if-eqz v13, :cond_d

    move v13, v7

    goto :goto_8

    :cond_d
    invoke-virtual {v11, v6}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v13

    array-length v13, v13

    :goto_8
    add-int/2addr v12, v13

    add-int/2addr v12, v9

    if-gt v12, v4, :cond_b

    .line 579
    invoke-virtual {v1, v10, v11}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move v9, v12

    goto :goto_6

    .line 584
    :cond_e
    invoke-static {}, Lcom/alibaba/sdk/android/tbrest/SendService;->getInstance()Lcom/alibaba/sdk/android/tbrest/SendService;

    move-result-object v4

    iget-object v4, v4, Lcom/alibaba/sdk/android/tbrest/SendService;->appKey:Ljava/lang/String;

    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v4, v1}, Lcom/alibaba/sdk/android/tool/CryptUtils;->aesGcmEncrypt(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 585
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_f

    new-array v4, v5, [Ljava/lang/Object;

    const-string v5, "crossPlatformCrashInfo"

    aput-object v5, v4, v7

    aput-object v1, v4, v2

    .line 586
    invoke-static {v3, v4}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 592
    :catchall_1
    :cond_f
    invoke-virtual {p0}, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$JavaExceptionReportBuilder;->buildEnd()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 593
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
