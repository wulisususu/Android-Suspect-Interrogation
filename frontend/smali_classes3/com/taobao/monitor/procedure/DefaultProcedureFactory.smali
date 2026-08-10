.class Lcom/taobao/monitor/procedure/DefaultProcedureFactory;
.super Ljava/lang/Object;
.source "ProcedureFactoryProxy.java"

# interfaces
.implements Lcom/taobao/monitor/procedure/IProcedureFactory;


# direct methods
.method constructor <init>()V
    .locals 0

    .line 38
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public createProcedure(Ljava/lang/String;)Lcom/taobao/monitor/procedure/IProcedure;
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "topic"
        }
    .end annotation

    .line 42
    sget-object p1, Lcom/taobao/monitor/procedure/IProcedure;->DEFAULT:Lcom/taobao/monitor/procedure/IProcedure;

    return-object p1
.end method

.method public createProcedure(Ljava/lang/String;Lcom/taobao/monitor/procedure/ProcedureConfig;)Lcom/taobao/monitor/procedure/IProcedure;
    .locals 0
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

    .line 47
    sget-object p1, Lcom/taobao/monitor/procedure/IProcedure;->DEFAULT:Lcom/taobao/monitor/procedure/IProcedure;

    return-object p1
.end method
