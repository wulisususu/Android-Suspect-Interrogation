.class Lcom/taobao/monitor/impl/trace/i$a;
.super Ljava/lang/Object;
.source "FPSDispatcher.java"

# interfaces
.implements Lcom/taobao/monitor/impl/trace/a$d;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/monitor/impl/trace/i;->a(I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/taobao/monitor/impl/trace/a$d<",
        "Lcom/taobao/monitor/impl/trace/i$c;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic a:I

.field final synthetic a:Lcom/taobao/monitor/impl/trace/i;


# direct methods
.method constructor <init>(Lcom/taobao/monitor/impl/trace/i;I)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/monitor/impl/trace/i$a;->a:Lcom/taobao/monitor/impl/trace/i;

    iput p2, p0, Lcom/taobao/monitor/impl/trace/i$a;->a:I

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lcom/taobao/monitor/impl/trace/i$c;)V
    .locals 1

    iget v0, p0, Lcom/taobao/monitor/impl/trace/i$a;->a:I

    .line 2
    invoke-interface {p1, v0}, Lcom/taobao/monitor/impl/trace/i$c;->d(I)V

    return-void
.end method

.method public bridge synthetic a(Ljava/lang/Object;)V
    .locals 0

    .line 1
    check-cast p1, Lcom/taobao/monitor/impl/trace/i$c;

    invoke-virtual {p0, p1}, Lcom/taobao/monitor/impl/trace/i$a;->a(Lcom/taobao/monitor/impl/trace/i$c;)V

    return-void
.end method
