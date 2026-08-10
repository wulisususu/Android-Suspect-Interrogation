.class public Lcom/taobao/monitor/procedure/ProcedureManager;
.super Ljava/lang/Object;
.source "ProcedureManager.java"

# interfaces
.implements Lcom/taobao/monitor/procedure/IProcedureManager;


# instance fields
.field private volatile activityProcedure:Lcom/taobao/monitor/procedure/IProcedure;

.field private final applicationProcedure:Lcom/taobao/monitor/procedure/IProcedure;

.field private volatile fragmentProcedure:Lcom/taobao/monitor/procedure/IProcedure;

.field private volatile launcherProcedure:Lcom/taobao/monitor/procedure/IProcedure;

.field private final root:Lcom/taobao/monitor/procedure/IProcedure;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 17
    sget-object v0, Lcom/taobao/monitor/procedure/IProcedure;->DEFAULT:Lcom/taobao/monitor/procedure/IProcedure;

    iput-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureManager;->root:Lcom/taobao/monitor/procedure/IProcedure;

    .line 18
    sget-object v0, Lcom/taobao/monitor/procedure/IProcedure;->DEFAULT:Lcom/taobao/monitor/procedure/IProcedure;

    iput-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureManager;->applicationProcedure:Lcom/taobao/monitor/procedure/IProcedure;

    .line 19
    sget-object v0, Lcom/taobao/monitor/procedure/IProcedure;->DEFAULT:Lcom/taobao/monitor/procedure/IProcedure;

    iput-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureManager;->launcherProcedure:Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method


# virtual methods
.method public getCurrentActivityProcedure()Lcom/taobao/monitor/procedure/IProcedure;
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureManager;->activityProcedure:Lcom/taobao/monitor/procedure/IProcedure;

    return-object v0
.end method

.method public getCurrentFragmentProcedure()Lcom/taobao/monitor/procedure/IProcedure;
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureManager;->fragmentProcedure:Lcom/taobao/monitor/procedure/IProcedure;

    return-object v0
.end method

.method public getCurrentProcedure()Lcom/taobao/monitor/procedure/IProcedure;
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureManager;->launcherProcedure:Lcom/taobao/monitor/procedure/IProcedure;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureManager;->launcherProcedure:Lcom/taobao/monitor/procedure/IProcedure;

    .line 59
    invoke-interface {v0}, Lcom/taobao/monitor/procedure/IProcedure;->isAlive()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureManager;->launcherProcedure:Lcom/taobao/monitor/procedure/IProcedure;

    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureManager;->activityProcedure:Lcom/taobao/monitor/procedure/IProcedure;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureManager;->activityProcedure:Lcom/taobao/monitor/procedure/IProcedure;

    return-object v0

    :cond_1
    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureManager;->fragmentProcedure:Lcom/taobao/monitor/procedure/IProcedure;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureManager;->fragmentProcedure:Lcom/taobao/monitor/procedure/IProcedure;

    return-object v0

    :cond_2
    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureManager;->applicationProcedure:Lcom/taobao/monitor/procedure/IProcedure;

    return-object v0
.end method

.method public getLauncherProcedure()Lcom/taobao/monitor/procedure/IProcedure;
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureManager;->launcherProcedure:Lcom/taobao/monitor/procedure/IProcedure;

    return-object v0
.end method

.method public getRootProcedure()Lcom/taobao/monitor/procedure/IProcedure;
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureManager;->root:Lcom/taobao/monitor/procedure/IProcedure;

    return-object v0
.end method

.method public setCurrentActivityProcedure(Lcom/taobao/monitor/procedure/IProcedure;)Lcom/taobao/monitor/procedure/IProcedure;
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "activityProcedure"
        }
    .end annotation

    iput-object p1, p0, Lcom/taobao/monitor/procedure/ProcedureManager;->activityProcedure:Lcom/taobao/monitor/procedure/IProcedure;

    return-object p1
.end method

.method public setCurrentFragmentProcedure(Lcom/taobao/monitor/procedure/IProcedure;)Lcom/taobao/monitor/procedure/IProcedure;
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "fragmentProcedure"
        }
    .end annotation

    iput-object p1, p0, Lcom/taobao/monitor/procedure/ProcedureManager;->fragmentProcedure:Lcom/taobao/monitor/procedure/IProcedure;

    return-object p1
.end method

.method public setLauncherProcedure(Lcom/taobao/monitor/procedure/IProcedure;)Lcom/taobao/monitor/procedure/IProcedure;
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "procedure"
        }
    .end annotation

    if-nez p1, :cond_0

    .line 95
    sget-object p1, Lcom/taobao/monitor/procedure/IProcedure;->DEFAULT:Lcom/taobao/monitor/procedure/IProcedure;

    iput-object p1, p0, Lcom/taobao/monitor/procedure/ProcedureManager;->launcherProcedure:Lcom/taobao/monitor/procedure/IProcedure;

    goto :goto_0

    :cond_0
    iput-object p1, p0, Lcom/taobao/monitor/procedure/ProcedureManager;->launcherProcedure:Lcom/taobao/monitor/procedure/IProcedure;

    :goto_0
    iget-object p1, p0, Lcom/taobao/monitor/procedure/ProcedureManager;->launcherProcedure:Lcom/taobao/monitor/procedure/IProcedure;

    return-object p1
.end method
