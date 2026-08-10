.class Lcom/taobao/monitor/procedure/DefaultProcedureManager;
.super Ljava/lang/Object;
.source "ProcedureManagerProxy.java"

# interfaces
.implements Lcom/taobao/monitor/procedure/IProcedureManager;


# direct methods
.method constructor <init>()V
    .locals 0

    .line 44
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public getCurrentActivityProcedure()Lcom/taobao/monitor/procedure/IProcedure;
    .locals 1

    .line 48
    sget-object v0, Lcom/taobao/monitor/procedure/IProcedure;->DEFAULT:Lcom/taobao/monitor/procedure/IProcedure;

    return-object v0
.end method

.method public getCurrentFragmentProcedure()Lcom/taobao/monitor/procedure/IProcedure;
    .locals 1

    .line 53
    sget-object v0, Lcom/taobao/monitor/procedure/IProcedure;->DEFAULT:Lcom/taobao/monitor/procedure/IProcedure;

    return-object v0
.end method

.method public getCurrentProcedure()Lcom/taobao/monitor/procedure/IProcedure;
    .locals 1

    .line 58
    sget-object v0, Lcom/taobao/monitor/procedure/IProcedure;->DEFAULT:Lcom/taobao/monitor/procedure/IProcedure;

    return-object v0
.end method

.method public getLauncherProcedure()Lcom/taobao/monitor/procedure/IProcedure;
    .locals 1

    .line 68
    sget-object v0, Lcom/taobao/monitor/procedure/IProcedure;->DEFAULT:Lcom/taobao/monitor/procedure/IProcedure;

    return-object v0
.end method

.method public getRootProcedure()Lcom/taobao/monitor/procedure/IProcedure;
    .locals 1

    .line 63
    sget-object v0, Lcom/taobao/monitor/procedure/IProcedure;->DEFAULT:Lcom/taobao/monitor/procedure/IProcedure;

    return-object v0
.end method
