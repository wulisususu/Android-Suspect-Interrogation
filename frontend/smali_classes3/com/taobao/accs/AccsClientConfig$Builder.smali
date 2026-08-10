.class public Lcom/taobao/accs/AccsClientConfig$Builder;
.super Ljava/lang/Object;
.source "Taobao"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/accs/AccsClientConfig;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "Builder"
.end annotation


# instance fields
.field private loopInterval:J

.field private mAccsHeartbeatEnable:Z

.field private mAppKey:Ljava/lang/String;

.field private mAppSecret:Ljava/lang/String;

.field private mAuthCode:Ljava/lang/String;

.field private mAutoUnit:Z

.field private mChannelHost:Ljava/lang/String;

.field private mChannelLoopStart:Z

.field private mChannelPubKey:I

.field private mConfigEnv:I

.field private mDisableChannel:Z

.field private mInappHost:Ljava/lang/String;

.field private mInappPubKey:I

.field private mKeepalive:Z

.field private mQuickReconnect:Z

.field private mStoreId:Ljava/lang/String;

.field private mTag:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 2

    .line 300
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, -0x1

    iput v0, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->mInappPubKey:I

    iput v0, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->mChannelPubKey:I

    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->mKeepalive:Z

    iput-boolean v1, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->mAutoUnit:Z

    iput v0, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->mConfigEnv:I

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->mDisableChannel:Z

    iput-boolean v0, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->mQuickReconnect:Z

    iput-boolean v0, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->mAccsHeartbeatEnable:Z

    iput-boolean v0, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->mChannelLoopStart:Z

    const-wide/32 v0, 0x493e0

    iput-wide v0, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->loopInterval:J

    return-void
.end method


# virtual methods
.method public build()Lcom/taobao/accs/AccsClientConfig;
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/taobao/accs/AccsException;
        }
    .end annotation

    iget-object v0, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->mAppKey:Ljava/lang/String;

    .line 456
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_8

    iget-object v0, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->mAppSecret:Ljava/lang/String;

    .line 459
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_7

    .line 462
    new-instance v0, Lcom/taobao/accs/AccsClientConfig;

    invoke-direct {v0}, Lcom/taobao/accs/AccsClientConfig;-><init>()V

    iget-object v1, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->mAppKey:Ljava/lang/String;

    .line 463
    invoke-static {v0, v1}, Lcom/taobao/accs/AccsClientConfig;->access$002(Lcom/taobao/accs/AccsClientConfig;Ljava/lang/String;)Ljava/lang/String;

    iget-object v1, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->mAppSecret:Ljava/lang/String;

    .line 464
    invoke-static {v0, v1}, Lcom/taobao/accs/AccsClientConfig;->access$102(Lcom/taobao/accs/AccsClientConfig;Ljava/lang/String;)Ljava/lang/String;

    iget-object v1, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->mAuthCode:Ljava/lang/String;

    .line 465
    invoke-static {v0, v1}, Lcom/taobao/accs/AccsClientConfig;->access$202(Lcom/taobao/accs/AccsClientConfig;Ljava/lang/String;)Ljava/lang/String;

    iget-boolean v1, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->mKeepalive:Z

    .line 466
    invoke-static {v0, v1}, Lcom/taobao/accs/AccsClientConfig;->access$302(Lcom/taobao/accs/AccsClientConfig;Z)Z

    iget-boolean v1, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->mAutoUnit:Z

    .line 467
    invoke-static {v0, v1}, Lcom/taobao/accs/AccsClientConfig;->access$402(Lcom/taobao/accs/AccsClientConfig;Z)Z

    iget v1, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->mInappPubKey:I

    .line 468
    invoke-static {v0, v1}, Lcom/taobao/accs/AccsClientConfig;->access$502(Lcom/taobao/accs/AccsClientConfig;I)I

    iget v1, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->mChannelPubKey:I

    .line 469
    invoke-static {v0, v1}, Lcom/taobao/accs/AccsClientConfig;->access$602(Lcom/taobao/accs/AccsClientConfig;I)I

    iget-object v1, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->mInappHost:Ljava/lang/String;

    .line 470
    invoke-static {v0, v1}, Lcom/taobao/accs/AccsClientConfig;->access$702(Lcom/taobao/accs/AccsClientConfig;Ljava/lang/String;)Ljava/lang/String;

    iget-object v1, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->mChannelHost:Ljava/lang/String;

    .line 471
    invoke-static {v0, v1}, Lcom/taobao/accs/AccsClientConfig;->access$802(Lcom/taobao/accs/AccsClientConfig;Ljava/lang/String;)Ljava/lang/String;

    iget-object v1, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->mTag:Ljava/lang/String;

    .line 472
    invoke-static {v0, v1}, Lcom/taobao/accs/AccsClientConfig;->access$902(Lcom/taobao/accs/AccsClientConfig;Ljava/lang/String;)Ljava/lang/String;

    iget-object v1, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->mStoreId:Ljava/lang/String;

    .line 473
    invoke-static {v0, v1}, Lcom/taobao/accs/AccsClientConfig;->access$1002(Lcom/taobao/accs/AccsClientConfig;Ljava/lang/String;)Ljava/lang/String;

    iget v1, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->mConfigEnv:I

    .line 474
    invoke-static {v0, v1}, Lcom/taobao/accs/AccsClientConfig;->access$1102(Lcom/taobao/accs/AccsClientConfig;I)I

    iget-boolean v1, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->mDisableChannel:Z

    .line 475
    invoke-static {v0, v1}, Lcom/taobao/accs/AccsClientConfig;->access$1202(Lcom/taobao/accs/AccsClientConfig;Z)Z

    iget-boolean v1, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->mQuickReconnect:Z

    .line 476
    invoke-static {v0, v1}, Lcom/taobao/accs/AccsClientConfig;->access$1302(Lcom/taobao/accs/AccsClientConfig;Z)Z

    iget-boolean v1, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->mAccsHeartbeatEnable:Z

    .line 477
    invoke-static {v0, v1}, Lcom/taobao/accs/AccsClientConfig;->access$1402(Lcom/taobao/accs/AccsClientConfig;Z)Z

    iget-boolean v1, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->mChannelLoopStart:Z

    .line 478
    invoke-static {v0, v1}, Lcom/taobao/accs/AccsClientConfig;->access$1502(Lcom/taobao/accs/AccsClientConfig;Z)Z

    iget-wide v1, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->loopInterval:J

    .line 479
    invoke-static {v0, v1, v2}, Lcom/taobao/accs/AccsClientConfig;->access$1602(Lcom/taobao/accs/AccsClientConfig;J)J

    .line 481
    invoke-static {v0}, Lcom/taobao/accs/AccsClientConfig;->access$1100(Lcom/taobao/accs/AccsClientConfig;)I

    move-result v1

    if-gez v1, :cond_0

    .line 482
    sget v1, Lcom/taobao/accs/AccsClientConfig;->mEnv:I

    invoke-static {v0, v1}, Lcom/taobao/accs/AccsClientConfig;->access$1102(Lcom/taobao/accs/AccsClientConfig;I)I

    :cond_0
    const/4 v1, 0x2

    .line 484
    invoke-static {v0, v1}, Lcom/taobao/accs/AccsClientConfig;->access$1702(Lcom/taobao/accs/AccsClientConfig;I)I

    .line 485
    invoke-static {v0}, Lcom/taobao/accs/AccsClientConfig;->access$700(Lcom/taobao/accs/AccsClientConfig;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 486
    sget-object v2, Lcom/taobao/accs/AccsClientConfig;->DEFAULT_CENTER_HOSTS:[Ljava/lang/String;

    invoke-static {v0}, Lcom/taobao/accs/AccsClientConfig;->access$1100(Lcom/taobao/accs/AccsClientConfig;)I

    move-result v3

    aget-object v2, v2, v3

    invoke-static {v0, v2}, Lcom/taobao/accs/AccsClientConfig;->access$702(Lcom/taobao/accs/AccsClientConfig;Ljava/lang/String;)Ljava/lang/String;

    .line 488
    :cond_1
    invoke-static {v0}, Lcom/taobao/accs/AccsClientConfig;->access$800(Lcom/taobao/accs/AccsClientConfig;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 489
    invoke-static {}, Lcom/taobao/accs/AccsClientConfig;->access$1800()[Ljava/lang/String;

    move-result-object v2

    invoke-static {v0}, Lcom/taobao/accs/AccsClientConfig;->access$1100(Lcom/taobao/accs/AccsClientConfig;)I

    move-result v3

    aget-object v2, v2, v3

    invoke-static {v0, v2}, Lcom/taobao/accs/AccsClientConfig;->access$802(Lcom/taobao/accs/AccsClientConfig;Ljava/lang/String;)Ljava/lang/String;

    .line 491
    :cond_2
    invoke-static {v0}, Lcom/taobao/accs/AccsClientConfig;->access$900(Lcom/taobao/accs/AccsClientConfig;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 492
    invoke-static {v0}, Lcom/taobao/accs/AccsClientConfig;->access$000(Lcom/taobao/accs/AccsClientConfig;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/taobao/accs/AccsClientConfig;->access$902(Lcom/taobao/accs/AccsClientConfig;Ljava/lang/String;)Ljava/lang/String;

    .line 495
    :cond_3
    invoke-static {v0}, Lcom/taobao/accs/AccsClientConfig;->access$1100(Lcom/taobao/accs/AccsClientConfig;)I

    move-result v2

    const/4 v3, 0x1

    if-eq v2, v3, :cond_5

    if-eq v2, v1, :cond_4

    .line 503
    invoke-static {}, Lcom/taobao/accs/AccsClientConfig;->access$2100()Ljava/util/Map;

    move-result-object v1

    goto :goto_0

    .line 500
    :cond_4
    invoke-static {}, Lcom/taobao/accs/AccsClientConfig;->access$2000()Ljava/util/Map;

    move-result-object v1

    goto :goto_0

    .line 497
    :cond_5
    invoke-static {}, Lcom/taobao/accs/AccsClientConfig;->access$1900()Ljava/util/Map;

    move-result-object v1

    .line 506
    :goto_0
    invoke-static {}, Lcom/taobao/accs/AccsClientConfig;->access$2200()Lcom/alibaba/sdk/android/logger/ILog;

    move-result-object v2

    const-string v3, "build config"

    filled-new-array {v3, v0}, [Ljava/lang/Object;

    move-result-object v3

    invoke-interface {v2, v3}, Lcom/alibaba/sdk/android/logger/ILog;->d([Ljava/lang/Object;)V

    .line 507
    invoke-virtual {v0}, Lcom/taobao/accs/AccsClientConfig;->getTag()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/taobao/accs/AccsClientConfig;

    if-eqz v2, :cond_6

    .line 509
    invoke-static {}, Lcom/taobao/accs/AccsClientConfig;->access$2200()Lcom/alibaba/sdk/android/logger/ILog;

    move-result-object v3

    const-string v4, "old"

    const-string v5, "new"

    const-string v6, "build cover"

    filled-new-array {v6, v4, v2, v5, v0}, [Ljava/lang/Object;

    move-result-object v2

    invoke-interface {v3, v2}, Lcom/alibaba/sdk/android/logger/ILog;->w([Ljava/lang/Object;)V

    .line 511
    :cond_6
    invoke-virtual {v0}, Lcom/taobao/accs/AccsClientConfig;->getTag()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1, v2, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-object v0

    .line 460
    :cond_7
    new-instance v0, Lcom/taobao/accs/AccsException;

    const-string v1, "appSecret null"

    invoke-direct {v0, v1}, Lcom/taobao/accs/AccsException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 457
    :cond_8
    new-instance v0, Lcom/taobao/accs/AccsException;

    const-string v1, "appkey null"

    invoke-direct {v0, v1}, Lcom/taobao/accs/AccsException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public loopChannelInterval(J)Lcom/taobao/accs/AccsClientConfig$Builder;
    .locals 0

    iput-wide p1, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->loopInterval:J

    return-object p0
.end method

.method public loopChannelStart(Z)Lcom/taobao/accs/AccsClientConfig$Builder;
    .locals 0

    iput-boolean p1, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->mChannelLoopStart:Z

    return-object p0
.end method

.method public setAccsHeartbeatEnable(Z)Lcom/taobao/accs/AccsClientConfig$Builder;
    .locals 0

    iput-boolean p1, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->mAccsHeartbeatEnable:Z

    return-object p0
.end method

.method public setAppKey(Ljava/lang/String;)Lcom/taobao/accs/AccsClientConfig$Builder;
    .locals 0

    iput-object p1, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->mAppKey:Ljava/lang/String;

    return-object p0
.end method

.method public setAppSecret(Ljava/lang/String;)Lcom/taobao/accs/AccsClientConfig$Builder;
    .locals 0

    iput-object p1, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->mAppSecret:Ljava/lang/String;

    return-object p0
.end method

.method public setAutoCode(Ljava/lang/String;)Lcom/taobao/accs/AccsClientConfig$Builder;
    .locals 0
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    iput-object p1, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->mAuthCode:Ljava/lang/String;

    return-object p0
.end method

.method public setAutoUnit(Z)Lcom/taobao/accs/AccsClientConfig$Builder;
    .locals 0

    iput-boolean p1, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->mAutoUnit:Z

    return-object p0
.end method

.method public setChannelHost(Ljava/lang/String;)Lcom/taobao/accs/AccsClientConfig$Builder;
    .locals 0

    iput-object p1, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->mChannelHost:Ljava/lang/String;

    return-object p0
.end method

.method public setChannelPubKey(I)Lcom/taobao/accs/AccsClientConfig$Builder;
    .locals 0

    iput p1, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->mChannelPubKey:I

    return-object p0
.end method

.method public setConfigEnv(I)Lcom/taobao/accs/AccsClientConfig$Builder;
    .locals 0

    iput p1, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->mConfigEnv:I

    return-object p0
.end method

.method public setDisableChannel(Z)Lcom/taobao/accs/AccsClientConfig$Builder;
    .locals 0

    iput-boolean p1, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->mDisableChannel:Z

    return-object p0
.end method

.method public setInappHost(Ljava/lang/String;)Lcom/taobao/accs/AccsClientConfig$Builder;
    .locals 0

    iput-object p1, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->mInappHost:Ljava/lang/String;

    return-object p0
.end method

.method public setInappPubKey(I)Lcom/taobao/accs/AccsClientConfig$Builder;
    .locals 0

    iput p1, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->mInappPubKey:I

    return-object p0
.end method

.method public setKeepAlive(Z)Lcom/taobao/accs/AccsClientConfig$Builder;
    .locals 0

    iput-boolean p1, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->mKeepalive:Z

    return-object p0
.end method

.method public setQuickReconnect(Z)Lcom/taobao/accs/AccsClientConfig$Builder;
    .locals 0

    iput-boolean p1, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->mQuickReconnect:Z

    return-object p0
.end method

.method public setStoreId(Ljava/lang/String;)Lcom/taobao/accs/AccsClientConfig$Builder;
    .locals 0

    iput-object p1, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->mStoreId:Ljava/lang/String;

    return-object p0
.end method

.method public setTag(Ljava/lang/String;)Lcom/taobao/accs/AccsClientConfig$Builder;
    .locals 0

    iput-object p1, p0, Lcom/taobao/accs/AccsClientConfig$Builder;->mTag:Ljava/lang/String;

    return-object p0
.end method
