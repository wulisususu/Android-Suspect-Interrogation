.class Lcom/aliyun/emas/apm/crash/k$a;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/aliyun/emas/apm/crash/s$a;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/aliyun/emas/apm/crash/k;->a(Ljava/lang/String;Ljava/lang/Thread$UncaughtExceptionHandler;Lcom/aliyun/emas/apm/settings/SettingProvider;Lcom/aliyun/emas/apm/crash/x0;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/aliyun/emas/apm/crash/k;


# direct methods
.method constructor <init>(Lcom/aliyun/emas/apm/crash/k;)V
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/k$a;->a:Lcom/aliyun/emas/apm/crash/k;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lcom/aliyun/emas/apm/settings/SettingProvider;Lcom/aliyun/emas/apm/crash/x0;Ljava/lang/Thread;Ljava/lang/Throwable;)V
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/k$a;->a:Lcom/aliyun/emas/apm/crash/k;

    .line 1
    invoke-virtual {v0, p1, p2, p3, p4}, Lcom/aliyun/emas/apm/crash/k;->a(Lcom/aliyun/emas/apm/settings/SettingProvider;Lcom/aliyun/emas/apm/crash/x0;Ljava/lang/Thread;Ljava/lang/Throwable;)V

    return-void
.end method
