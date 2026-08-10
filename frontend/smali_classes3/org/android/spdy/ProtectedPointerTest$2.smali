.class final Lorg/android/spdy/ProtectedPointerTest$2;
.super Ljava/lang/Object;
.source "ProtectedPointerTest.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lorg/android/spdy/ProtectedPointerTest;->test_close_with_work(Lorg/android/spdy/ProtectedPointer;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic val$pptr:Lorg/android/spdy/ProtectedPointer;


# direct methods
.method constructor <init>(Lorg/android/spdy/ProtectedPointer;)V
    .locals 0

    iput-object p1, p0, Lorg/android/spdy/ProtectedPointerTest$2;->val$pptr:Lorg/android/spdy/ProtectedPointer;

    .line 50
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    iget-object v0, p0, Lorg/android/spdy/ProtectedPointerTest$2;->val$pptr:Lorg/android/spdy/ProtectedPointer;

    .line 53
    invoke-virtual {v0}, Lorg/android/spdy/ProtectedPointer;->release()V

    return-void
.end method
