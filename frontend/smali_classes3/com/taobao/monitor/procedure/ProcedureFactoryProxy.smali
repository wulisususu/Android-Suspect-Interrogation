.class public Lcom/taobao/monitor/procedure/ProcedureFactoryProxy;
.super Ljava/lang/Object;
.source "ProcedureFactoryProxy.java"

# interfaces
.implements Lcom/taobao/monitor/procedure/IProcedureFactory;


# static fields
.field public static PROXY:Lcom/taobao/monitor/procedure/ProcedureFactoryProxy;


# instance fields
.field private real:Lcom/taobao/monitor/procedure/IProcedureFactory;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 6
    new-instance v0, Lcom/taobao/monitor/procedure/ProcedureFactoryProxy;

    invoke-direct {v0}, Lcom/taobao/monitor/procedure/ProcedureFactoryProxy;-><init>()V

    sput-object v0, Lcom/taobao/monitor/procedure/ProcedureFactoryProxy;->PROXY:Lcom/taobao/monitor/procedure/ProcedureFactoryProxy;

    return-void
.end method

.method private constructor <init>()V
    .locals 1

    .line 9
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 7
    new-instance v0, Lcom/taobao/monitor/procedure/DefaultProcedureFactory;

    invoke-direct {v0}, Lcom/taobao/monitor/procedure/DefaultProcedureFactory;-><init>()V

    iput-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureFactoryProxy;->real:Lcom/taobao/monitor/procedure/IProcedureFactory;

    return-void
.end method


# virtual methods
.method public createProcedure(Ljava/lang/String;)Lcom/taobao/monitor/procedure/IProcedure;
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "topic"
        }
    .end annotation

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureFactoryProxy;->real:Lcom/taobao/monitor/procedure/IProcedureFactory;

    .line 22
    invoke-interface {v0, p1}, Lcom/taobao/monitor/procedure/IProcedureFactory;->createProcedure(Ljava/lang/String;)Lcom/taobao/monitor/procedure/IProcedure;

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

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureFactoryProxy;->real:Lcom/taobao/monitor/procedure/IProcedureFactory;

    .line 30
    invoke-interface {v0, p1, p2}, Lcom/taobao/monitor/procedure/IProcedureFactory;->createProcedure(Ljava/lang/String;Lcom/taobao/monitor/procedure/ProcedureConfig;)Lcom/taobao/monitor/procedure/IProcedure;

    move-result-object p1

    return-object p1
.end method

.method public setReal(Lcom/taobao/monitor/procedure/IProcedureFactory;)Lcom/taobao/monitor/procedure/ProcedureFactoryProxy;
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "real"
        }
    .end annotation

    iput-object p1, p0, Lcom/taobao/monitor/procedure/ProcedureFactoryProxy;->real:Lcom/taobao/monitor/procedure/IProcedureFactory;

    return-object p0
.end method
