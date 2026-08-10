.class public Lcom/taobao/monitor/impl/trace/d;
.super Lcom/taobao/monitor/impl/trace/a;
.source "ApplicationBackgroundChangedDispatcher.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/monitor/impl/trace/d$b;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/taobao/monitor/impl/trace/a<",
        "Lcom/taobao/monitor/impl/trace/d$b;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 1
    invoke-direct {p0}, Lcom/taobao/monitor/impl/trace/a;-><init>()V

    return-void
.end method


# virtual methods
.method public a(IJ)V
    .locals 1

    .line 1
    new-instance v0, Lcom/taobao/monitor/impl/trace/d$a;

    invoke-direct {v0, p0, p1, p2, p3}, Lcom/taobao/monitor/impl/trace/d$a;-><init>(Lcom/taobao/monitor/impl/trace/d;IJ)V

    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/trace/a;->a(Lcom/taobao/monitor/impl/trace/a$d;)V

    return-void
.end method
