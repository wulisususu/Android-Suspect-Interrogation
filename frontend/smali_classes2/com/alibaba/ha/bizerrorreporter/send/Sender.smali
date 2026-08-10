.class public Lcom/alibaba/ha/bizerrorreporter/send/Sender;
.super Ljava/lang/Object;
.source "Sender.java"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field bizErrorModule:Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;

.field mContext:Landroid/content/Context;


# direct methods
.method public constructor <init>(Landroid/content/Context;Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "context",
            "module"
        }
    .end annotation

    .line 27
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/alibaba/ha/bizerrorreporter/send/Sender;->mContext:Landroid/content/Context;

    iput-object p2, p0, Lcom/alibaba/ha/bizerrorreporter/send/Sender;->bizErrorModule:Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;

    return-void
.end method

.method private canSend()Ljava/lang/Boolean;
    .locals 6

    .line 75
    invoke-static {}, Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;->getInstance()Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;

    move-result-object v0

    iget-object v0, v0, Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;->sampling:Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;

    const/16 v1, 0x2710

    const/4 v2, 0x0

    .line 104
    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    .line 76
    invoke-direct {p0, v2, v1}, Lcom/alibaba/ha/bizerrorreporter/send/Sender;->getRandomNumber(II)I

    move-result v1

    .line 77
    sget-object v2, Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;->OneTenth:Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;

    const/4 v4, 0x1

    .line 80
    invoke-static {v4}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v5

    if-ne v0, v2, :cond_0

    if-ltz v1, :cond_5

    const/16 v0, 0x3e8

    if-ge v1, v0, :cond_5

    return-object v5

    .line 82
    :cond_0
    sget-object v2, Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;->OnePercent:Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;

    if-ne v0, v2, :cond_1

    if-ltz v1, :cond_5

    const/16 v0, 0x64

    if-ge v1, v0, :cond_5

    return-object v5

    .line 87
    :cond_1
    sget-object v2, Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;->OneThousandth:Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;

    if-ne v0, v2, :cond_2

    if-ltz v1, :cond_5

    const/16 v0, 0xa

    if-ge v1, v0, :cond_5

    return-object v5

    .line 92
    :cond_2
    sget-object v2, Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;->OneTenThousandth:Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;

    if-ne v0, v2, :cond_3

    if-ltz v1, :cond_5

    if-ge v1, v4, :cond_5

    return-object v5

    .line 97
    :cond_3
    sget-object v1, Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;->Zero:Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;

    if-ne v0, v1, :cond_4

    return-object v3

    .line 100
    :cond_4
    sget-object v1, Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;->All:Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;

    if-ne v0, v1, :cond_5

    return-object v5

    :cond_5
    return-object v3
.end method

.method private getRandomNumber(II)I
    .locals 4
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "from",
            "to"
        }
    .end annotation

    .line 112
    :try_start_0
    invoke-static {}, Ljava/lang/Math;->random()D

    move-result-wide v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    sub-int/2addr p2, p1

    add-int/lit8 p2, p2, 0x1

    int-to-double v2, p2

    mul-double/2addr v0, v2

    double-to-int p2, v0

    add-int/2addr p1, p2

    return p1

    :catch_0
    move-exception p1

    const-string p2, "MotuCrashAdapter"

    const-string v0, "get random number err"

    .line 114
    invoke-static {p2, v0, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    const/4 p1, 0x0

    return p1
.end method


# virtual methods
.method public run()V
    .locals 17

    move-object/from16 v1, p0

    const-string v0, ", error type: "

    const-string v2, "MotuCrashAdapter"

    const-string v3, "send error log "

    const-string v4, "start send error log. appkey: "

    :try_start_0
    iget-object v5, v1, Lcom/alibaba/ha/bizerrorreporter/send/Sender;->bizErrorModule:Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;

    .line 36
    iget-object v5, v5, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->businessType:Ljava/lang/String;

    if-nez v5, :cond_0

    const-string v0, "business type cannot null"

    .line 39
    invoke-static {v2, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    return-void

    .line 44
    :cond_0
    invoke-static {}, Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;->getInstance()Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;

    move-result-object v5

    iget-object v5, v5, Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;->sampling:Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;

    if-eqz v5, :cond_1

    .line 45
    invoke-direct/range {p0 .. p0}, Lcom/alibaba/ha/bizerrorreporter/send/Sender;->canSend()Ljava/lang/Boolean;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v5

    if-nez v5, :cond_1

    return-void

    .line 52
    :cond_1
    new-instance v5, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder;

    invoke-direct {v5}, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder;-><init>()V

    iget-object v6, v1, Lcom/alibaba/ha/bizerrorreporter/send/Sender;->mContext:Landroid/content/Context;

    iget-object v7, v1, Lcom/alibaba/ha/bizerrorreporter/send/Sender;->bizErrorModule:Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;

    .line 53
    invoke-virtual {v5, v6, v7}, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder;->build(Landroid/content/Context;Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;)Lcom/alibaba/ha/bizerrorreporter/module/SendModule;

    move-result-object v5

    if-eqz v5, :cond_3

    .line 55
    iget-object v6, v5, Lcom/alibaba/ha/bizerrorreporter/module/SendModule;->eventId:Ljava/lang/Integer;

    .line 56
    iget-object v13, v5, Lcom/alibaba/ha/bizerrorreporter/module/SendModule;->sendFlag:Ljava/lang/String;

    .line 57
    iget-object v14, v5, Lcom/alibaba/ha/bizerrorreporter/module/SendModule;->sendContent:Ljava/lang/String;

    .line 58
    iget-object v11, v5, Lcom/alibaba/ha/bizerrorreporter/module/SendModule;->businessType:Ljava/lang/String;

    .line 59
    iget-object v15, v5, Lcom/alibaba/ha/bizerrorreporter/module/SendModule;->aggregationType:Ljava/lang/String;

    .line 61
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {}, Lcom/alibaba/sdk/android/tbrest/SendService;->getInstance()Lcom/alibaba/sdk/android/tbrest/SendService;

    move-result-object v4

    iget-object v4, v4, Lcom/alibaba/sdk/android/tbrest/SendService;->appKey:Ljava/lang/String;

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, v1, Lcom/alibaba/ha/bizerrorreporter/send/Sender;->bizErrorModule:Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;

    iget-object v5, v5, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->businessType:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v2, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 62
    invoke-static {}, Lcom/alibaba/sdk/android/tbrest/SendService;->getInstance()Lcom/alibaba/sdk/android/tbrest/SendService;

    move-result-object v7

    const/4 v8, 0x0

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v9

    invoke-virtual {v6}, Ljava/lang/Integer;->intValue()I

    move-result v12

    iget-object v4, v1, Lcom/alibaba/ha/bizerrorreporter/send/Sender;->bizErrorModule:Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;

    iget-object v4, v4, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->args:Ljava/util/Map;

    move-object/from16 v16, v4

    invoke-virtual/range {v7 .. v16}, Lcom/alibaba/sdk/android/tbrest/SendService;->sendRequest(Ljava/lang/String;JLjava/lang/String;ILjava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/util/Map;)Ljava/lang/Boolean;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v4

    .line 63
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    if-eqz v4, :cond_2

    const-string v3, "success"

    goto :goto_0

    :cond_2
    const-string v3, "failed"

    :goto_0
    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ". appkey: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-static {}, Lcom/alibaba/sdk/android/tbrest/SendService;->getInstance()Lcom/alibaba/sdk/android/tbrest/SendService;

    move-result-object v4

    iget-object v4, v4, Lcom/alibaba/sdk/android/tbrest/SendService;->appKey:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v3, v1, Lcom/alibaba/ha/bizerrorreporter/send/Sender;->bizErrorModule:Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;

    iget-object v3, v3, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->businessType:Ljava/lang/String;

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v2, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    move-exception v0

    const-string v3, "send business err happen "

    .line 66
    invoke-static {v2, v3, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :cond_3
    :goto_1
    return-void
.end method
