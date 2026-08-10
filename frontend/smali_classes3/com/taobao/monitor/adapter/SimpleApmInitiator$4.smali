.class Lcom/taobao/monitor/adapter/SimpleApmInitiator$4;
.super Ljava/lang/Object;
.source "SimpleApmInitiator.java"

# interfaces
.implements Lcom/taobao/monitor/impl/processor/pageload/IProcedureManager;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/monitor/adapter/SimpleApmInitiator;->initAPMLauncher(Landroid/app/Application;Ljava/util/HashMap;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/taobao/monitor/adapter/SimpleApmInitiator;


# direct methods
.method constructor <init>(Lcom/taobao/monitor/adapter/SimpleApmInitiator;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010
        }
        names = {
            "this$0"
        }
    .end annotation

    iput-object p1, p0, Lcom/taobao/monitor/adapter/SimpleApmInitiator$4;->this$0:Lcom/taobao/monitor/adapter/SimpleApmInitiator;

    .line 261
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public setCurrentActivityProcedure(Lcom/taobao/monitor/procedure/IProcedure;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "currentActivityProcedure"
        }
    .end annotation

    .line 264
    sget-object v0, Lcom/taobao/monitor/ProcedureGlobal;->PROCEDURE_MANAGER:Lcom/taobao/monitor/procedure/ProcedureManager;

    invoke-virtual {v0, p1}, Lcom/taobao/monitor/procedure/ProcedureManager;->setCurrentActivityProcedure(Lcom/taobao/monitor/procedure/IProcedure;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method

.method public setCurrentFragmentProcedure(Lcom/taobao/monitor/procedure/IProcedure;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "currentFragmentProcedure"
        }
    .end annotation

    .line 269
    sget-object v0, Lcom/taobao/monitor/ProcedureGlobal;->PROCEDURE_MANAGER:Lcom/taobao/monitor/procedure/ProcedureManager;

    invoke-virtual {v0, p1}, Lcom/taobao/monitor/procedure/ProcedureManager;->setCurrentFragmentProcedure(Lcom/taobao/monitor/procedure/IProcedure;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method

.method public setCurrentLauncherProcedure(Lcom/taobao/monitor/procedure/IProcedure;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "launcherProcedure"
        }
    .end annotation

    .line 274
    sget-object v0, Lcom/taobao/monitor/ProcedureGlobal;->PROCEDURE_MANAGER:Lcom/taobao/monitor/procedure/ProcedureManager;

    invoke-virtual {v0, p1}, Lcom/taobao/monitor/procedure/ProcedureManager;->setLauncherProcedure(Lcom/taobao/monitor/procedure/IProcedure;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method
