.class public interface abstract Lcom/taobao/monitor/procedure/IProcedureGroup;
.super Ljava/lang/Object;
.source "IProcedureGroup.java"

# interfaces
.implements Lcom/taobao/monitor/procedure/IProcedure;


# virtual methods
.method public abstract addSubProcedure(Lcom/taobao/monitor/procedure/IProcedure;)V
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "subProcedure"
        }
    .end annotation
.end method

.method public abstract removeSubProcedure(Lcom/taobao/monitor/procedure/IProcedure;)V
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "subProcedure"
        }
    .end annotation
.end method
