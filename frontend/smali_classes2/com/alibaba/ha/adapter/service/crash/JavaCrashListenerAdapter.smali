.class public Lcom/alibaba/ha/adapter/service/crash/JavaCrashListenerAdapter;
.super Ljava/lang/Object;
.source "JavaCrashListenerAdapter.java"

# interfaces
.implements Lcom/alibaba/motu/crashreporter/IUTCrashCaughtListener;


# instance fields
.field public javaCrashListener:Lcom/alibaba/ha/adapter/service/crash/JavaCrashListener;


# direct methods
.method public constructor <init>(Lcom/alibaba/ha/adapter/service/crash/JavaCrashListener;)V
    .locals 0

    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/alibaba/ha/adapter/service/crash/JavaCrashListenerAdapter;->javaCrashListener:Lcom/alibaba/ha/adapter/service/crash/JavaCrashListener;

    return-void
.end method


# virtual methods
.method public onCrashCaught(Ljava/lang/Thread;Ljava/lang/Throwable;)Ljava/util/Map;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Thread;",
            "Ljava/lang/Throwable;",
            ")",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/alibaba/ha/adapter/service/crash/JavaCrashListenerAdapter;->javaCrashListener:Lcom/alibaba/ha/adapter/service/crash/JavaCrashListener;

    if-eqz v0, :cond_0

    .line 31
    invoke-interface {v0, p1, p2}, Lcom/alibaba/ha/adapter/service/crash/JavaCrashListener;->onCrashCaught(Ljava/lang/Thread;Ljava/lang/Throwable;)Ljava/util/Map;

    move-result-object p1

    return-object p1

    :cond_0
    const/4 p1, 0x0

    return-object p1
.end method
