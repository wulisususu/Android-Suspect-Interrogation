.class public interface abstract Lcom/taobao/monitor/procedure/ProcedureImpl$IProcedureLifeCycle;
.super Ljava/lang/Object;
.source "ProcedureImpl.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/monitor/procedure/ProcedureImpl;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x609
    name = "IProcedureLifeCycle"
.end annotation


# virtual methods
.method public abstract begin(Lcom/taobao/monitor/procedure/Value;)V
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "value"
        }
    .end annotation
.end method

.method public abstract end(Lcom/taobao/monitor/procedure/Value;Z)V
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "value",
            "needUpload"
        }
    .end annotation
.end method

.method public abstract event(Lcom/taobao/monitor/procedure/Value;Lcom/taobao/monitor/procedure/model/Event;)V
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "value",
            "event"
        }
    .end annotation
.end method

.method public abstract stage(Lcom/taobao/monitor/procedure/Value;Lcom/taobao/monitor/procedure/model/Stage;)V
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "value",
            "stage"
        }
    .end annotation
.end method
