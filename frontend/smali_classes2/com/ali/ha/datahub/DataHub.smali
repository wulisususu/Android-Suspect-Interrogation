.class public Lcom/ali/ha/datahub/DataHub;
.super Ljava/lang/Object;
.source "DataHub.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/ali/ha/datahub/DataHub$SubProcedure;,
        Lcom/ali/ha/datahub/DataHub$SingleInstanceHolder;
    }
.end annotation


# instance fields
.field private mSubProcedure:Lcom/ali/ha/datahub/DataHub$SubProcedure;

.field private mSubscriber:Lcom/ali/ha/datahub/BizSubscriber;


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 13
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/ali/ha/datahub/DataHub$1;)V
    .locals 0

    .line 8
    invoke-direct {p0}, Lcom/ali/ha/datahub/DataHub;-><init>()V

    return-void
.end method

.method public static final getInstance()Lcom/ali/ha/datahub/DataHub;
    .locals 1

    .line 21
    sget-object v0, Lcom/ali/ha/datahub/DataHub$SingleInstanceHolder;->sInstance:Lcom/ali/ha/datahub/DataHub;

    return-object v0
.end method

.method private subProcedure()Lcom/ali/ha/datahub/DataHub$SubProcedure;
    .locals 2

    iget-object v0, p0, Lcom/ali/ha/datahub/DataHub;->mSubProcedure:Lcom/ali/ha/datahub/DataHub$SubProcedure;

    if-nez v0, :cond_0

    .line 105
    new-instance v0, Lcom/ali/ha/datahub/DataHub$SubProcedure;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/ali/ha/datahub/DataHub$SubProcedure;-><init>(Lcom/ali/ha/datahub/DataHub$1;)V

    iput-object v0, p0, Lcom/ali/ha/datahub/DataHub;->mSubProcedure:Lcom/ali/ha/datahub/DataHub$SubProcedure;

    :cond_0
    iget-object v0, p0, Lcom/ali/ha/datahub/DataHub;->mSubProcedure:Lcom/ali/ha/datahub/DataHub$SubProcedure;

    return-object v0
.end method


# virtual methods
.method public init(Lcom/ali/ha/datahub/BizSubscriber;)V
    .locals 2

    iget-object v0, p0, Lcom/ali/ha/datahub/DataHub;->mSubscriber:Lcom/ali/ha/datahub/BizSubscriber;

    if-nez v0, :cond_0

    iput-object p1, p0, Lcom/ali/ha/datahub/DataHub;->mSubscriber:Lcom/ali/ha/datahub/BizSubscriber;

    .line 99
    new-instance p1, Lcom/ali/ha/datahub/DataHub$SubProcedure;

    iget-object v0, p0, Lcom/ali/ha/datahub/DataHub;->mSubscriber:Lcom/ali/ha/datahub/BizSubscriber;

    const/4 v1, 0x0

    invoke-direct {p1, v0, v1}, Lcom/ali/ha/datahub/DataHub$SubProcedure;-><init>(Lcom/ali/ha/datahub/BizSubscriber;Lcom/ali/ha/datahub/DataHub$1;)V

    iput-object p1, p0, Lcom/ali/ha/datahub/DataHub;->mSubProcedure:Lcom/ali/ha/datahub/DataHub$SubProcedure;

    :cond_0
    return-void
.end method

.method public onBizDataReadyStage()V
    .locals 1

    iget-object v0, p0, Lcom/ali/ha/datahub/DataHub;->mSubscriber:Lcom/ali/ha/datahub/BizSubscriber;

    if-nez v0, :cond_0

    return-void

    .line 93
    :cond_0
    invoke-interface {v0}, Lcom/ali/ha/datahub/BizSubscriber;->onBizDataReadyStage()V

    return-void
.end method

.method public onStage(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    .line 53
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    invoke-virtual {p0, p1, p2, v0, v1}, Lcom/ali/ha/datahub/DataHub;->onStage(Ljava/lang/String;Ljava/lang/String;J)V

    return-void
.end method

.method public onStage(Ljava/lang/String;Ljava/lang/String;J)V
    .locals 1

    iget-object v0, p0, Lcom/ali/ha/datahub/DataHub;->mSubscriber:Lcom/ali/ha/datahub/BizSubscriber;

    if-nez v0, :cond_0

    return-void

    .line 64
    :cond_0
    invoke-interface {v0, p1, p2, p3, p4}, Lcom/ali/ha/datahub/BizSubscriber;->onStage(Ljava/lang/String;Ljava/lang/String;J)V

    return-void
.end method

.method public publish(Ljava/lang/String;Ljava/util/HashMap;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/HashMap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    iget-object v0, p0, Lcom/ali/ha/datahub/DataHub;->mSubscriber:Lcom/ali/ha/datahub/BizSubscriber;

    if-nez v0, :cond_0

    return-void

    .line 32
    :cond_0
    invoke-interface {v0, p1, p2}, Lcom/ali/ha/datahub/BizSubscriber;->pub(Ljava/lang/String;Ljava/util/HashMap;)V

    return-void
.end method

.method public publishABTest(Ljava/lang/String;Ljava/util/HashMap;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/HashMap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    iget-object v0, p0, Lcom/ali/ha/datahub/DataHub;->mSubscriber:Lcom/ali/ha/datahub/BizSubscriber;

    if-nez v0, :cond_0

    return-void

    .line 43
    :cond_0
    invoke-interface {v0, p1, p2}, Lcom/ali/ha/datahub/BizSubscriber;->pubAB(Ljava/lang/String;Ljava/util/HashMap;)V

    return-void
.end method

.method public setCurrentBiz(Ljava/lang/String;)V
    .locals 2

    iget-object v0, p0, Lcom/ali/ha/datahub/DataHub;->mSubscriber:Lcom/ali/ha/datahub/BizSubscriber;

    if-nez v0, :cond_0

    return-void

    :cond_0
    const/4 v1, 0x0

    .line 85
    invoke-interface {v0, p1, v1}, Lcom/ali/ha/datahub/BizSubscriber;->setMainBiz(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public setCurrentBiz(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/ali/ha/datahub/DataHub;->mSubscriber:Lcom/ali/ha/datahub/BizSubscriber;

    if-nez v0, :cond_0

    return-void

    .line 75
    :cond_0
    invoke-interface {v0, p1, p2}, Lcom/ali/ha/datahub/BizSubscriber;->setMainBiz(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method
