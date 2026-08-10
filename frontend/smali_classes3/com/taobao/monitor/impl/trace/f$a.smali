.class Lcom/taobao/monitor/impl/trace/f$a;
.super Ljava/lang/Object;
.source "ApplicationLowMemoryDispatcher.java"

# interfaces
.implements Lcom/taobao/monitor/impl/trace/a$d;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/monitor/impl/trace/f;->a()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/taobao/monitor/impl/trace/a$d<",
        "Lcom/taobao/monitor/impl/trace/f$b;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic a:Lcom/taobao/monitor/impl/trace/f;


# direct methods
.method constructor <init>(Lcom/taobao/monitor/impl/trace/f;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/monitor/impl/trace/f$a;->a:Lcom/taobao/monitor/impl/trace/f;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lcom/taobao/monitor/impl/trace/f$b;)V
    .locals 0

    .line 2
    invoke-interface {p1}, Lcom/taobao/monitor/impl/trace/f$b;->onLowMemory()V

    return-void
.end method

.method public bridge synthetic a(Ljava/lang/Object;)V
    .locals 0

    .line 1
    check-cast p1, Lcom/taobao/monitor/impl/trace/f$b;

    invoke-virtual {p0, p1}, Lcom/taobao/monitor/impl/trace/f$a;->a(Lcom/taobao/monitor/impl/trace/f$b;)V

    return-void
.end method
