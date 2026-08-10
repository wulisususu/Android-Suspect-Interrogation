.class public Lcom/taobao/android/tlog/protocol/model/reply/base/PerformanceInfo;
.super Ljava/util/LinkedHashMap;
.source "PerformanceInfo.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/util/LinkedHashMap<",
        "Ljava/lang/String;",
        "Ljava/lang/String;",
        ">;"
    }
.end annotation


# static fields
.field private static final serialVersionUID:J = 0x1L


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 12
    invoke-direct {p0}, Ljava/util/LinkedHashMap;-><init>()V

    return-void
.end method


# virtual methods
.method public set(Ljava/lang/String;Ljava/lang/String;)Lcom/taobao/android/tlog/protocol/model/reply/base/PerformanceInfo;
    .locals 0

    .line 16
    invoke-virtual {p0, p1, p2}, Lcom/taobao/android/tlog/protocol/model/reply/base/PerformanceInfo;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-object p0
.end method
