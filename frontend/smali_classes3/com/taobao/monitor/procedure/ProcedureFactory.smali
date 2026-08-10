.class public Lcom/taobao/monitor/procedure/ProcedureFactory;
.super Ljava/lang/Object;
.source "ProcedureFactory.java"

# interfaces
.implements Lcom/taobao/monitor/procedure/IProcedureFactory;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 6
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private createProcedureImpl(Ljava/lang/String;Lcom/taobao/monitor/procedure/ProcedureConfig;)Lcom/taobao/monitor/procedure/ProcedureImpl;
    .locals 4
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "topic",
            "config"
        }
    .end annotation

    .line 45
    invoke-virtual {p2}, Lcom/taobao/monitor/procedure/ProcedureConfig;->getParent()Lcom/taobao/monitor/procedure/IProcedure;

    move-result-object v0

    .line 46
    sget-object v1, Lcom/taobao/monitor/procedure/IProcedure;->DEFAULT:Lcom/taobao/monitor/procedure/IProcedure;

    if-ne v0, v1, :cond_0

    .line 47
    sget-object v0, Lcom/taobao/monitor/ProcedureGlobal;->PROCEDURE_MANAGER:Lcom/taobao/monitor/procedure/ProcedureManager;

    invoke-virtual {v0}, Lcom/taobao/monitor/procedure/ProcedureManager;->getCurrentProcedure()Lcom/taobao/monitor/procedure/IProcedure;

    move-result-object v0

    .line 50
    :cond_0
    new-instance v1, Lcom/taobao/monitor/procedure/ProcedureImpl;

    invoke-virtual {p2}, Lcom/taobao/monitor/procedure/ProcedureConfig;->isIndependent()Z

    move-result v2

    invoke-virtual {p2}, Lcom/taobao/monitor/procedure/ProcedureConfig;->isParentNeedStats()Z

    move-result v3

    invoke-direct {v1, p1, v0, v2, v3}, Lcom/taobao/monitor/procedure/ProcedureImpl;-><init>(Ljava/lang/String;Lcom/taobao/monitor/procedure/IProcedure;ZZ)V

    .line 51
    invoke-virtual {p2}, Lcom/taobao/monitor/procedure/ProcedureConfig;->isUpload()Z

    move-result p1

    if-eqz p1, :cond_1

    .line 52
    new-instance p1, Lcom/taobao/monitor/network/ProcedureLifecycleImpl;

    invoke-direct {p1}, Lcom/taobao/monitor/network/ProcedureLifecycleImpl;-><init>()V

    invoke-virtual {v1, p1}, Lcom/taobao/monitor/procedure/ProcedureImpl;->setLifeCycle(Lcom/taobao/monitor/procedure/ProcedureImpl$IProcedureLifeCycle;)Lcom/taobao/monitor/procedure/ProcedureImpl;

    :cond_1
    return-object v1
.end method


# virtual methods
.method public createProcedure(Ljava/lang/String;)Lcom/taobao/monitor/procedure/IProcedure;
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "topic"
        }
    .end annotation

    .line 16
    new-instance v0, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    invoke-direct {v0}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;-><init>()V

    const/4 v1, 0x0

    .line 17
    invoke-virtual {v0, v1}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->setUpload(Z)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    move-result-object v0

    const/4 v1, 0x1

    .line 18
    invoke-virtual {v0, v1}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->setIndependent(Z)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    move-result-object v0

    .line 19
    invoke-virtual {v0, v1}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->setParentNeedStats(Z)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    move-result-object v0

    sget-object v1, Lcom/taobao/monitor/ProcedureGlobal;->PROCEDURE_MANAGER:Lcom/taobao/monitor/procedure/ProcedureManager;

    .line 20
    invoke-virtual {v1}, Lcom/taobao/monitor/procedure/ProcedureManager;->getCurrentProcedure()Lcom/taobao/monitor/procedure/IProcedure;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->setParent(Lcom/taobao/monitor/procedure/IProcedure;)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    move-result-object v0

    .line 21
    invoke-virtual {v0}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->build()Lcom/taobao/monitor/procedure/ProcedureConfig;

    move-result-object v0

    invoke-virtual {p0, p1, v0}, Lcom/taobao/monitor/procedure/ProcedureFactory;->createProcedure(Ljava/lang/String;Lcom/taobao/monitor/procedure/ProcedureConfig;)Lcom/taobao/monitor/procedure/IProcedure;

    move-result-object p1

    return-object p1
.end method

.method public createProcedure(Ljava/lang/String;Lcom/taobao/monitor/procedure/ProcedureConfig;)Lcom/taobao/monitor/procedure/IProcedure;
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "topic",
            "config"
        }
    .end annotation

    if-nez p2, :cond_0

    .line 33
    new-instance p2, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    invoke-direct {p2}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;-><init>()V

    const/4 v0, 0x0

    .line 34
    invoke-virtual {p2, v0}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->setUpload(Z)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    move-result-object p2

    const/4 v0, 0x1

    .line 35
    invoke-virtual {p2, v0}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->setIndependent(Z)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    move-result-object p2

    .line 36
    invoke-virtual {p2, v0}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->setParentNeedStats(Z)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    move-result-object p2

    sget-object v0, Lcom/taobao/monitor/ProcedureGlobal;->PROCEDURE_MANAGER:Lcom/taobao/monitor/procedure/ProcedureManager;

    .line 37
    invoke-virtual {v0}, Lcom/taobao/monitor/procedure/ProcedureManager;->getCurrentProcedure()Lcom/taobao/monitor/procedure/IProcedure;

    move-result-object v0

    invoke-virtual {p2, v0}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->setParent(Lcom/taobao/monitor/procedure/IProcedure;)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    move-result-object p2

    .line 38
    invoke-virtual {p2}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->build()Lcom/taobao/monitor/procedure/ProcedureConfig;

    move-result-object p2

    .line 40
    :cond_0
    invoke-direct {p0, p1, p2}, Lcom/taobao/monitor/procedure/ProcedureFactory;->createProcedureImpl(Ljava/lang/String;Lcom/taobao/monitor/procedure/ProcedureConfig;)Lcom/taobao/monitor/procedure/ProcedureImpl;

    move-result-object p1

    .line 41
    new-instance p2, Lcom/taobao/monitor/procedure/ProcedureProxy;

    invoke-direct {p2, p1}, Lcom/taobao/monitor/procedure/ProcedureProxy;-><init>(Lcom/taobao/monitor/procedure/ProcedureImpl;)V

    return-object p2
.end method
