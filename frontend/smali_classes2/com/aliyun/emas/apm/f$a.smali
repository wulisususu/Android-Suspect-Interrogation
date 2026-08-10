.class Lcom/aliyun/emas/apm/f$a;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/google/android/gms/tasks/OnSuccessListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/aliyun/emas/apm/f;->b(Ljava/lang/Long;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/Long;

.field final synthetic b:Lcom/aliyun/emas/apm/f;


# direct methods
.method constructor <init>(Lcom/aliyun/emas/apm/f;Ljava/lang/Long;)V
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/f$a;->b:Lcom/aliyun/emas/apm/f;

    iput-object p2, p0, Lcom/aliyun/emas/apm/f$a;->a:Ljava/lang/Long;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lcom/aliyun/emas/apm/settings/Settings;)V
    .locals 1

    .line 1
    new-instance p1, Lcom/aliyun/emas/apm/f$a$a;

    invoke-direct {p1, p0}, Lcom/aliyun/emas/apm/f$a$a;-><init>(Lcom/aliyun/emas/apm/f$a;)V

    .line 23
    new-instance v0, Ljava/lang/Thread;

    invoke-direct {v0, p1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    return-void
.end method

.method public bridge synthetic onSuccess(Ljava/lang/Object;)V
    .locals 0

    .line 1
    check-cast p1, Lcom/aliyun/emas/apm/settings/Settings;

    invoke-virtual {p0, p1}, Lcom/aliyun/emas/apm/f$a;->a(Lcom/aliyun/emas/apm/settings/Settings;)V

    return-void
.end method
