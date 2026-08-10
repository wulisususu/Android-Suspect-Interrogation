.class Lcom/taobao/monitor/adapter/DataHubProcedureGroupHelper;
.super Ljava/lang/Object;
.source "DataHubProcedureGroupHelper.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/monitor/adapter/DataHubProcedureGroupHelper$ProcedureGroup;
    }
.end annotation


# static fields
.field private static final groups:Lcom/taobao/monitor/adapter/DataHubProcedureGroupHelper$ProcedureGroup;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 17
    new-instance v0, Lcom/taobao/monitor/adapter/DataHubProcedureGroupHelper$ProcedureGroup;

    invoke-direct {v0}, Lcom/taobao/monitor/adapter/DataHubProcedureGroupHelper$ProcedureGroup;-><init>()V

    sput-object v0, Lcom/taobao/monitor/adapter/DataHubProcedureGroupHelper;->groups:Lcom/taobao/monitor/adapter/DataHubProcedureGroupHelper$ProcedureGroup;

    return-void
.end method

.method constructor <init>()V
    .locals 0

    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getCurrentProcedures()Lcom/taobao/monitor/procedure/IProcedure;
    .locals 2

    sget-object v0, Lcom/taobao/monitor/adapter/DataHubProcedureGroupHelper;->groups:Lcom/taobao/monitor/adapter/DataHubProcedureGroupHelper$ProcedureGroup;

    .line 21
    invoke-static {v0}, Lcom/taobao/monitor/adapter/DataHubProcedureGroupHelper$ProcedureGroup;->access$000(Lcom/taobao/monitor/adapter/DataHubProcedureGroupHelper$ProcedureGroup;)V

    .line 22
    sget-object v1, Lcom/taobao/monitor/procedure/ProcedureManagerProxy;->PROXY:Lcom/taobao/monitor/procedure/ProcedureManagerProxy;

    invoke-virtual {v1}, Lcom/taobao/monitor/procedure/ProcedureManagerProxy;->getLauncherProcedure()Lcom/taobao/monitor/procedure/IProcedure;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/taobao/monitor/adapter/DataHubProcedureGroupHelper$ProcedureGroup;->access$100(Lcom/taobao/monitor/adapter/DataHubProcedureGroupHelper$ProcedureGroup;Lcom/taobao/monitor/procedure/IProcedure;)V

    .line 23
    sget-object v1, Lcom/taobao/monitor/procedure/ProcedureManagerProxy;->PROXY:Lcom/taobao/monitor/procedure/ProcedureManagerProxy;

    invoke-virtual {v1}, Lcom/taobao/monitor/procedure/ProcedureManagerProxy;->getCurrentActivityProcedure()Lcom/taobao/monitor/procedure/IProcedure;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/taobao/monitor/adapter/DataHubProcedureGroupHelper$ProcedureGroup;->access$100(Lcom/taobao/monitor/adapter/DataHubProcedureGroupHelper$ProcedureGroup;Lcom/taobao/monitor/procedure/IProcedure;)V

    .line 24
    sget-object v1, Lcom/taobao/monitor/procedure/ProcedureManagerProxy;->PROXY:Lcom/taobao/monitor/procedure/ProcedureManagerProxy;

    invoke-virtual {v1}, Lcom/taobao/monitor/procedure/ProcedureManagerProxy;->getCurrentFragmentProcedure()Lcom/taobao/monitor/procedure/IProcedure;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/taobao/monitor/adapter/DataHubProcedureGroupHelper$ProcedureGroup;->access$100(Lcom/taobao/monitor/adapter/DataHubProcedureGroupHelper$ProcedureGroup;Lcom/taobao/monitor/procedure/IProcedure;)V

    return-object v0
.end method
