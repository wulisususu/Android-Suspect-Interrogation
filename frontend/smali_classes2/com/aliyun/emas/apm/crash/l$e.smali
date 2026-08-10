.class Lcom/aliyun/emas/apm/crash/l$e;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/util/concurrent/Callable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/aliyun/emas/apm/crash/l;->a()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/aliyun/emas/apm/crash/l;


# direct methods
.method constructor <init>(Lcom/aliyun/emas/apm/crash/l;)V
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/l$e;->a:Lcom/aliyun/emas/apm/crash/l;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a()Ljava/lang/Boolean;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/l$e;->a:Lcom/aliyun/emas/apm/crash/l;

    .line 1
    invoke-static {v0}, Lcom/aliyun/emas/apm/crash/l;->b(Lcom/aliyun/emas/apm/crash/l;)Lcom/aliyun/emas/apm/crash/k;

    move-result-object v0

    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/k;->a()Z

    move-result v0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic call()Ljava/lang/Object;
    .locals 1

    .line 1
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/crash/l$e;->a()Ljava/lang/Boolean;

    move-result-object v0

    return-object v0
.end method
