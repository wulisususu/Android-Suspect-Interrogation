.class public Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter;
.super Ljava/lang/Object;
.source "ProcedureManagerSetter.java"

# interfaces
.implements Lcom/taobao/monitor/impl/processor/pageload/IProcedureManager;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter$b;,
        Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter$c;
    }
.end annotation


# instance fields
.field private proxy:Lcom/taobao/monitor/impl/processor/pageload/IProcedureManager;


# direct methods
.method private constructor <init>()V
    .locals 2

    .line 2
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 3
    new-instance v0, Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter$b;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter$b;-><init>(Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter$a;)V

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter;->proxy:Lcom/taobao/monitor/impl/processor/pageload/IProcedureManager;

    return-void
.end method

.method synthetic constructor <init>(Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter$a;)V
    .locals 0

    .line 1
    invoke-direct {p0}, Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter;-><init>()V

    return-void
.end method

.method public static instance()Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter;
    .locals 1

    .line 1
    sget-object v0, Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter$c;->a:Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter;

    return-object v0
.end method


# virtual methods
.method public setCurrentActivityProcedure(Lcom/taobao/monitor/procedure/IProcedure;)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter;->proxy:Lcom/taobao/monitor/impl/processor/pageload/IProcedureManager;

    .line 1
    invoke-interface {v0, p1}, Lcom/taobao/monitor/impl/processor/pageload/IProcedureManager;->setCurrentActivityProcedure(Lcom/taobao/monitor/procedure/IProcedure;)V

    return-void
.end method

.method public setCurrentFragmentProcedure(Lcom/taobao/monitor/procedure/IProcedure;)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter;->proxy:Lcom/taobao/monitor/impl/processor/pageload/IProcedureManager;

    .line 1
    invoke-interface {v0, p1}, Lcom/taobao/monitor/impl/processor/pageload/IProcedureManager;->setCurrentFragmentProcedure(Lcom/taobao/monitor/procedure/IProcedure;)V

    return-void
.end method

.method public setCurrentLauncherProcedure(Lcom/taobao/monitor/procedure/IProcedure;)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter;->proxy:Lcom/taobao/monitor/impl/processor/pageload/IProcedureManager;

    .line 1
    invoke-interface {v0, p1}, Lcom/taobao/monitor/impl/processor/pageload/IProcedureManager;->setCurrentLauncherProcedure(Lcom/taobao/monitor/procedure/IProcedure;)V

    return-void
.end method

.method public setProxy(Lcom/taobao/monitor/impl/processor/pageload/IProcedureManager;)Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter;
    .locals 0

    iput-object p1, p0, Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter;->proxy:Lcom/taobao/monitor/impl/processor/pageload/IProcedureManager;

    return-object p0
.end method
