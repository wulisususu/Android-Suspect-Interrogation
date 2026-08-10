.class Lcom/aliyun/emas/apm/crash/j$a;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/aliyun/emas/apm/crash/j;-><init>(Ljava/util/concurrent/Executor;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/aliyun/emas/apm/crash/j;


# direct methods
.method constructor <init>(Lcom/aliyun/emas/apm/crash/j;)V
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/j$a;->a:Lcom/aliyun/emas/apm/crash/j;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/j$a;->a:Lcom/aliyun/emas/apm/crash/j;

    .line 1
    invoke-static {v0}, Lcom/aliyun/emas/apm/crash/j;->a(Lcom/aliyun/emas/apm/crash/j;)Ljava/lang/ThreadLocal;

    move-result-object v0

    sget-object v1, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-virtual {v0, v1}, Ljava/lang/ThreadLocal;->set(Ljava/lang/Object;)V

    return-void
.end method
