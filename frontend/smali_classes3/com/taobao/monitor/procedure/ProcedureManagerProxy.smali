.class public Lcom/taobao/monitor/procedure/ProcedureManagerProxy;
.super Ljava/lang/Object;
.source "ProcedureManagerProxy.java"

# interfaces
.implements Lcom/taobao/monitor/procedure/IProcedureManager;


# static fields
.field public static PROXY:Lcom/taobao/monitor/procedure/ProcedureManagerProxy;


# instance fields
.field private real:Lcom/taobao/monitor/procedure/IProcedureManager;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 5
    new-instance v0, Lcom/taobao/monitor/procedure/ProcedureManagerProxy;

    invoke-direct {v0}, Lcom/taobao/monitor/procedure/ProcedureManagerProxy;-><init>()V

    sput-object v0, Lcom/taobao/monitor/procedure/ProcedureManagerProxy;->PROXY:Lcom/taobao/monitor/procedure/ProcedureManagerProxy;

    return-void
.end method

.method private constructor <init>()V
    .locals 1

    .line 9
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 7
    new-instance v0, Lcom/taobao/monitor/procedure/DefaultProcedureManager;

    invoke-direct {v0}, Lcom/taobao/monitor/procedure/DefaultProcedureManager;-><init>()V

    iput-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureManagerProxy;->real:Lcom/taobao/monitor/procedure/IProcedureManager;

    return-void
.end method


# virtual methods
.method public getCurrentActivityProcedure()Lcom/taobao/monitor/procedure/IProcedure;
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureManagerProxy;->real:Lcom/taobao/monitor/procedure/IProcedureManager;

    .line 19
    invoke-interface {v0}, Lcom/taobao/monitor/procedure/IProcedureManager;->getCurrentActivityProcedure()Lcom/taobao/monitor/procedure/IProcedure;

    move-result-object v0

    return-object v0
.end method

.method public getCurrentFragmentProcedure()Lcom/taobao/monitor/procedure/IProcedure;
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureManagerProxy;->real:Lcom/taobao/monitor/procedure/IProcedureManager;

    .line 24
    invoke-interface {v0}, Lcom/taobao/monitor/procedure/IProcedureManager;->getCurrentFragmentProcedure()Lcom/taobao/monitor/procedure/IProcedure;

    move-result-object v0

    return-object v0
.end method

.method public getCurrentProcedure()Lcom/taobao/monitor/procedure/IProcedure;
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureManagerProxy;->real:Lcom/taobao/monitor/procedure/IProcedureManager;

    .line 29
    invoke-interface {v0}, Lcom/taobao/monitor/procedure/IProcedureManager;->getCurrentProcedure()Lcom/taobao/monitor/procedure/IProcedure;

    move-result-object v0

    return-object v0
.end method

.method public getLauncherProcedure()Lcom/taobao/monitor/procedure/IProcedure;
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureManagerProxy;->real:Lcom/taobao/monitor/procedure/IProcedureManager;

    .line 39
    invoke-interface {v0}, Lcom/taobao/monitor/procedure/IProcedureManager;->getLauncherProcedure()Lcom/taobao/monitor/procedure/IProcedure;

    move-result-object v0

    return-object v0
.end method

.method public getRootProcedure()Lcom/taobao/monitor/procedure/IProcedure;
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureManagerProxy;->real:Lcom/taobao/monitor/procedure/IProcedureManager;

    .line 34
    invoke-interface {v0}, Lcom/taobao/monitor/procedure/IProcedureManager;->getRootProcedure()Lcom/taobao/monitor/procedure/IProcedure;

    move-result-object v0

    return-object v0
.end method

.method public setReal(Lcom/taobao/monitor/procedure/IProcedureManager;)Lcom/taobao/monitor/procedure/ProcedureManagerProxy;
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "real"
        }
    .end annotation

    iput-object p1, p0, Lcom/taobao/monitor/procedure/ProcedureManagerProxy;->real:Lcom/taobao/monitor/procedure/IProcedureManager;

    return-object p0
.end method
