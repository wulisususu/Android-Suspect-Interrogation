.class public interface abstract Lcom/taobao/monitor/procedure/IProcedureFactory;
.super Ljava/lang/Object;
.source "IProcedureFactory.java"


# virtual methods
.method public abstract createProcedure(Ljava/lang/String;)Lcom/taobao/monitor/procedure/IProcedure;
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "topic"
        }
    .end annotation
.end method

.method public abstract createProcedure(Ljava/lang/String;Lcom/taobao/monitor/procedure/ProcedureConfig;)Lcom/taobao/monitor/procedure/IProcedure;
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
.end method
